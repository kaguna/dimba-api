class Api::V1::LeagueStandingsController < ApplicationController
  include Standings
  def show
    render json: league_table_data(params[:league_id], params[:season_id])
  end
end
