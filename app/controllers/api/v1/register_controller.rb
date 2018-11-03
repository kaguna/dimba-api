module Api
  module V1
    class RegisterController < ApplicationController
      def signup
        user = User.new(user_params)

        if user.save
          render json: user, status: :created

        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def user_params
        params.permit(
          :username,
          :email,
          :role_id,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
