module Api
  module V1
    class LeagueStandingsController < ApplicationController

      def index
        render json: AllResult.standings(params[:league_id])
      end
    end
  end
end
