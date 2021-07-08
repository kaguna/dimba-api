module Api
  module V1
    class SeasonsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      after_action :verify_authorized, except: %i(index show)

      def create
        season = Season.new(season_params)
        authorize season
        if season.save
          render json: season, status: :created
        else
          render json: season.errors, status: :unprocessable_entity
        end
      end

      private
      
      def season_params
        params.permit(
          :name,
          :description,
          :league_id
        )
      end
    end
  end
end
