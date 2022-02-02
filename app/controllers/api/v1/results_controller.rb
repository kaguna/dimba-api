module Api
  module V1
    class ResultsController < ApplicationController
      include Standing
      before_action :authenticate_current_user!, only: %i(create update destroy)
      after_action :verify_authorized, only: %i[create]
      
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
        render json: TeamSeasonLeagueGamesQuery.call('home_team_id', params[:team_id], true)
      end

      def show_team_away_results
        render json: TeamSeasonLeagueGamesQuery.call('away_team_id', params[:team_id], true)
      end

      def player_stats
        render json: AllResult.player_stats(params[:league_id])
      end

      def all_incoming_matches
        render json: AllResult.all_incoming_matches
      end

      def create
        result = Result.new(result_params)
        authorize result

        if result.save!
          render json: result, status: :created
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      def update
      end

      def destroy
      end

      private

      def all_matches
        Result.league_season_matches_results(params[:league_id], params[:per_page], params[:page])
      end

      def result_params
        params.permit(
          :fixture_id,
          :home_goals,
          :away_goals
        )
      end

    end
  end
end
