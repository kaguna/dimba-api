module Api
  module V1
    class RegisterController < ApplicationController
      def signup
        user = User.new(user_params)
        user.role_id = Role.find_by(name: "User")&.id
        if user.save
          UserMailer.with(to: user).registration_confirmation.deliver_now
          render json: user, status: :created

        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def confirm_email
        user = User.find_by_confirm_token(params[:confirmation_token])
        if user
          user.email_activate
          message = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
          redirect_to 'https://www.chezadimba.co.ke/login'
        else
          message = "Sorry. User does not exist"
          redirect_to 'https://www.chezadimba.co.ke/register'
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
