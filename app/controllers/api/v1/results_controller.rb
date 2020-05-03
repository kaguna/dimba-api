module Api
  module V1
    class ResultsController < ApplicationController
      before_action :authenticate_current_user!, except: [:matches_results, :match_result, :league_season_standing]

      def matches_results
        render json: Result.league_season_matches_results(params[:league_id], params[:season_id])
      end

      def match_result
        render json: Result.full_match_results(params[:match_id])
      end

      def league_season_standing
        render json: Result.standing(params[:league_id], params[:season_id])
      end

      def player_stats
        render json: Result.player_stats(params[:league_id], params[:season_id])
      end
    end
  end
end
