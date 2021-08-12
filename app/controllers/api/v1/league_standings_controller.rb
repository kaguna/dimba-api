module Api
  module V1
    class LeagueStandingsController < ApplicationController

      def index
        render json: AllResult.standings(params[:league_id], params[:season_id])
      end

      def archived_season
        render json: AllResult.standings(params[:league_id], params[:season_id])
      end
    end
  end
end
