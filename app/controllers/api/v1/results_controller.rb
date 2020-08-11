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
        render json: Result.full_match_results(params[:match_id])
      end

      # def league_season_standing
      #   render json: AllResult.standing(params[:league_id])
      # end

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
