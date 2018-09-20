class SessionsController < ApplicationController

  def create
      user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      render json: user, status: :ok

    else
      render json: {"message": "Invalid credentials"}, status: :unauthorized
    end
  end
end
