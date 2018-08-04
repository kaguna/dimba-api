class TeamsController < ApplicationController

  def create_new_team
    @create_team = Team.new(team_params)

    if @create_team.save
      render json: @create_team, status: :created
    else
      render json: @create_team.errors, status: :unprocessable_entity
    end
  end

  def show_all_teams
    render json: Team.all, status: :ok
  end

  def team_params
    params.permit(
        :name,
        :description,
        :location,
        :nickname
    )
  end
end
