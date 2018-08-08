class TeamsController < ApplicationController

  def create
    @create_team = Team.new(team_params)

    if @create_team.save
      render json: @create_team, status: :created
    else
      render json: @create_team.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Team.all, status: :ok
  end

  private

  def team_params
    params.permit(
        :name,
        :description,
        :location,
        :nickname
    )
  end
end
