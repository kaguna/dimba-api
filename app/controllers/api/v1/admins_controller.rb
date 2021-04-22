module Api
  module V1
    class AdminsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index get_referees get_coaches]
      before_action :set_user, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show get_referees get_coaches]

      def index
        render json: User.search(params[:q])
      end

      def get_referees
        render json: User.get_all_referees
      end

      def get_coaches
        render json: User.get_all_coaches
      end

      def update
        authorize @user
        if @user
          @user.update_attributes(update_params)
          render json: { message: 'User Role updated!' }, status: :ok

        else
          render json: { message: 'The user does not exist!' },
            status: :bad_request
        end
      end

      private
      
      def set_user
        @user = User.find(params[:user_id])
      end

      def update_params
        params.permit(
          :role_id
        )
      end
    end
  end
end
