class Api::V1::LeagueStandingsController < ApplicationController
  def show
    render json: Standings::Statistics.new(league_id: params[:league_id],
                                           season_id: params[:season_id])
                                      .league_stats
  end
end
