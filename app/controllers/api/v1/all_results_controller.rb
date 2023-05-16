module Api
  module V1
    class AllResultsController < ApplicationController
      before_action :authenticate_current_user!, only: %i(create update destroy)
      
      def matches_results
        render json: AllResult.league_season_matches_results(params[:league_id])
      end

      def match_result
        render json: AllResult.full_match_results(params[:match_id])
      end

      def league_season_standing
        render json: AllResult.standings(params[:league_id])
      end

      def player_stats
        render json: AllResult.player_stats(params[:league_id], params[:season_id])
      end

      def all_incoming_matches
        render json: AllResult.all_incoming_matches(params[:match_day])
      end

      def create
      end

      def update
      end

      def destroy
      end

    end
  end
end
