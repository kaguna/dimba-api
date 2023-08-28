# frozen_string_literal: true

module Api
  module V1
    class LeaguesController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_league, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show]

      def index
        active_leagues = League.active
        leagues = current_user.present? && current_user.email_confirmed ? League.ordered_by_favourites(current_user: current_user) : active_leagues
        all_leagues = leagues.all_paginated_leagues(per_page: params[:per_page].to_i, page: params[:page].to_i)
        if leagues.empty?
          render json: { "error": 'No leagues!' },
                 status: :not_found

        else
          render json: {
            leagues: ActiveModelSerializers::SerializableResource.new(all_leagues,
                                                                      each_serializer: LeagueSerializer,
                                                                      scope: { current_user: current_user,
                                                                               show: 'all' }),
            total: active_leagues.count
          }, status: :ok
        end
      end

      def show
        render json: @league, scope: { current_user: current_user, show: 'details' }
      end

      def create
        league = League.new(league_params)
        authorize league

        if league.save
          render json: league, status: :created

        else
          render json: league.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @league
        @league.update_attributes(league_params)
        render json: @league
      end

      def destroy
        authorize @league
        @league.destroy
      end

      private

      def set_league
        @league = League.find(params[:id])
      end

      def league_params
        params.permit(
          :title,
          :season,
          :official_id
        )
      end
    end
  end
end
