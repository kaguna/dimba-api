class Api::V1::LeaguesTeamsController < ApplicationController
  before_action :authenticate_current_user, except: %i[index show]
  before_action :set_league_teams, only: %i[show update destroy]
  after_action :verify_authorized, except: %i[index show]

  def index
    render json: show_league_teams(params[:league_id])
  end

  def show
    render json: @league_team
  end

  def create
    render json: create_league_teams
  end

  def update
    authorize @league_team
    if @league_team.nil?
      render json: { message: 'Team not found' }, status: :not_found
    else
      @league_team.update_attributes(update_params)
      render json: @league_team
    end
  end

  def destroy
    authorize @league_team
    @league_team.nil? ?
    (render json: { message: 'Team not found' }, status: :not_found) :
    @league_team.destroy
  end

  private

  def create_league_teams
    teams_paramaters.each do |attributes|
      league_team = LeaguesTeam.new(teams_params(attributes))
      authorize league_team
      league_team.league_id = params[:league_id]
      league_team.save!
    end
  end

  def set_league_teams
    @league_team = LeaguesTeam.find_by(league_id: params[:league_id],
                                      id: params[:id])
  end

  def teams_params(attributes)
    attributes.permit(:team_id)
  end

  def teams_paramaters
    params.require(:league_teams)
  end

  def update_params
    params.permit(:team_id)
  end

  def show_league_teams(league_id)
    league_teams ||= League.find(league_id).teams
  end
end
