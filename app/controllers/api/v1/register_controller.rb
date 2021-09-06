module Api
  module V1
    class RegisterController < ApplicationController
      def signup
        user = User.new(user_params)
        user.role_id = Role.find_by(name: "User")&.id
        if user.save
          UserMailer.with(to: user).welcome_email.deliver_now
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
