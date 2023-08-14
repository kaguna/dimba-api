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

      def show_password_reset_form
        user = find_user_by_reset_token
        if user
          render json: user, status: :ok

        else
          render json: user, status: :unprocessable_entity
        end
      end

      def reset_password
        user = find_user_by_reset_token
        if user
          user.update!(password: params[:password])
          render json: user, status: :ok

        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def send_reset_password_token
        user = User.find_by(email: params[:email])
        if user
          user.update!(password_reset_token: SecureRandom.urlsafe_base64.to_s)
          SendResetPasswordTokenMailer.send_reset_password_token(user).deliver_now
          render json: user, status: :ok

        else
          render json: {error: "Email not found"}, status: :not_found
        end
      end

      private

      def find_user_by_reset_token
        User.find_by(password_reset_token: params[:password_reset_token])
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
