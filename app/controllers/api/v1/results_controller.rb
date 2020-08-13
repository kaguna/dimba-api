module Api
  module V1
    class ResultsController < ApplicationController
      include Standing
      before_action :authenticate_current_user!, only: %i(create update destroy)
      
      def index
        render json: all_matches
      end

      def show_table
        # not used, refactor later
        render json: league_season_standings(index)
      end

      def show
        render json: Result.full_match_results(params[:match_id]).first
      end

      def show_team_home_results
        render json: Result.team_home_results(params[:team_id])
      end

      def show_team_away_results
        render json: Result.team_away_results(params[:team_id])
      end

      def player_stats
        render json: AllResult.player_stats(params[:league_id])
      end

      def all_incoming_matches
        render json: AllResult.all_incoming_matches
      end

      def create
      end

      def update
      end

      def destroy
      end

      private

      def all_matches
        Result.league_season_matches_results(params[:league_id])
      end

    end
  end
end
