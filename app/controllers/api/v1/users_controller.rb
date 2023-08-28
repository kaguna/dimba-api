module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!, only: :current

      def current
        render json: current_user, status: :ok
      end
    end
  end
end
