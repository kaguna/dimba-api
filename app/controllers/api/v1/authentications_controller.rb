# frozen_string_literal: true

#   Exposes API for user authentication.
#
#   We first notice the advantage of the service AuthenticateUser here.
#   Instead we would have defined our logic here, which is not good for
#   readability and reuse.
#
#   We don't need a token when signing in hence
#   skip_before_action.

module Api
  module V1
    class AuthenticationsController < ApplicationController
      before_action :authorize_api_request, except: :authenticate

      def authenticate
        auth_token = AuthenticateUser.new(params[:email], params[:password]).call

        render json: { jwt: auth_token }, status: :ok
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end
