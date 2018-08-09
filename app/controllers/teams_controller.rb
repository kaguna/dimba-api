class TeamsController < ApplicationController

  def index
    render json: Team.all, status: :ok
  end

  def show
    show_team = Team.find_by(id: params[:team_id])

    if show_team
      render json: show_team, status: :ok

    else
      render json: {
          errors: 'The team does not exist'
      }, status: :bad_request
    end
  end

  def create
    @create_team = Team.new(team_params)

    if @create_team.save
      render json: @create_team, status: :created

    else
      render json: @create_team.errors, status: :unprocessable_entity
    end
  end

  def update
    edit_team = Team.find_by(id: params[:team_id])

    if edit_team
      edit_team.update_attributes(team_params)
      render json: edit_team, status: :ok

    else
      render json: {
          errors: 'The team does not exist'
      }, status: :bad_request
    end
  end

  def destroy
    delete_team = Team.find_by(id: params[:team_id])

    if delete_team
      delete_team.destroy
      render json: { message: "Team was successfully deleted" }, status: :ok

    else
      render json: { errors: "The team does not exist" }, status: :bad_request
    end
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
