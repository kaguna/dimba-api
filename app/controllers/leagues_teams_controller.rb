class LeaguesTeamsController < ApplicationController

  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_league_teams, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    league_teams = LeaguesTeam.where(league_id: params[:league_id])

    if league_teams.empty?
      render json: { errors: "No teams for this league." },
             status: :bad_request

    else
      render json: league_teams, status: :ok
    end
  end

  def show
    league_team = LeaguesTeam.where(id: params[:league_team_id],
                                    league_id: params[:league_id])

    if league_team.empty?
      render json: { error: "The league team is not available." },
             status: :bad_request

    else
      render json: league_team, status: :ok
    end
  end

  def create
    create_league_teams
    render json:
               {
                 message: "#{teams_paramaters.size} team(s) added to the league"
               }, status: :created
    rescue ActiveRecord::RecordInvalid
      record_invalid("Team(s) exists in this league")
  end

  def update
    if @league_team
      @league_team.update_attributes(update_params)
      render json: @league_team, status: :ok

    else
      render json: { errors: "The team does not exist in the league" },
             status: :bad_request
    end
  end

  def destroy
    if @league_team
      @league_team.destroy
      render json: { message: "Team was removed from league" },
             status: :ok

    else
      render json: { errors: "The team does not exist in the league" },
             status: :bad_request
    end
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
    @league_team = LeaguesTeam.find_by(id: params[:league_team_id],
                                       league_id: params[:league_id])
    authorize @league_team
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
end
