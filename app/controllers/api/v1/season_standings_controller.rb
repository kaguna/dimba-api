module Api
  module V1
    class SeasonStandingsController < ApplicationController

      def archived_season
        render json: SeasonStanding.archived_season(season_id: params[:season_id])
      end
    end
  end
end
