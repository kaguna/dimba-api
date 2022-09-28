module Api
  module V1   
    class LeaguesController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_league, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show]

      def index
        all_leagues = League.active
        leagues = all_leagues.limit(params[:per_page].to_i).offset(params[:page].to_i)

        if leagues.empty?
          render json: { "error": 'No leagues!' },
                status: :not_found

        else
          render json: {leagues: leagues, total: all_leagues.length}, each_serializer: LeagueSerializer, status: :ok
        end
      end

      def show
        render json: @league
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
