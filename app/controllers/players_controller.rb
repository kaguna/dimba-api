class PlayersController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_player, only: %i(show update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    players = Player.where(team_id: params[:team_id])

    if players.empty?
      render json: { errors: "The team does not exist" },
             status: :bad_request

    else
      render json: players, status: :ok
    end
  end

  def show
    if @player
      render json: @player, status: :ok

    else
      render json: { errors: "The player does not exist" },
             status: :bad_request
    end
  end

  def create
    create_player = Player.new(player_params)
    authorize create_player

    if create_player.save
      render json: create_player, status: :created

    else
      render json: create_player.errors, status: :unprocessable_entity
    end
  end

  def update
    if @player
      @player.update_attributes(player_params)
      render json: @player, status: :ok

    else
      render json: { errors: "The player does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @player
      @player.destroy
      render json: { message: "Player was successfully deleted" }, status: :ok

    else
      render json: { errors: "The player does not exist" }, status: :bad_request
    end
  end

  private

  def set_player
    @player = Player.find_by(id: params[:player_id], team_id: params[:team_id])
    authorize @player
  end

  def player_params
    params.permit(
      :first_name,
      :second_name,
      :last_name,
      :nick_name,
      :id_number,
      :dob,
      :phone_number,
      :team_id
    )
  end
end
