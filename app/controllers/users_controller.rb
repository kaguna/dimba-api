class UsersController < ApplicationController

  # def show
  #   if @player
  #     render json: @player, status: :ok
  #
  #   else
  #     render json: { errors: "The player does not exist" },
  #            status: :bad_request
  #   end
  # end

  def signup
    user = User.new(user_params)

    if user.save
      render json: user, status: :created

    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   if @player
  #     @player.update_attributes(player_params)
  #     render json: @player, status: :ok
  #
  #   else
  #     render json: { errors: "The player does not exist" },
  #            status: :bad_request
  #   end
  # end
  #
  # def destroy
  #   if @player
  #     @player.destroy
  #     render json: { message: "Player was successfully deleted" }, status: :ok
  #
  #   else
  #     render json: { errors: "The player does not exist" }, status: :bad_request
  #   end
  # end
  #
  # private
  #
  # def set_player
  #   @player = Player.find_by(id: params[:player_id], team_id: params[:team_id])
  # end

  def user_params
    params.permit(
        :username,
        :email,
        :role,
        :password
    )
  end
end

