module Api
  module V1
    class SeasonsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show season_matches]
      after_action :verify_authorized, except: %i(index show season_matches)

      def index
        seasons = League.find(params[:league_id]).seasons.archived
        render json: seasons, relevant: false
      end

      def season_matches
        matches = Result.league_season_matches_results(
          params[:league_id], 
          params[:season_id], 
          params[:per_page], 
          params[:page]
        )
        serialized_results = ActiveModelSerializers::SerializableResource.new(matches[:results],
                                                                      each_serializer: ResultSerializer,
                                                                      relevant: false,
                                                                      scope: { current_user: current_user,
                                                                               show: 'all' })                                                         
        render json: { count: matches[:count], results: serialized_results }, status: :ok
      end

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
