module Api
  module V1
    class ErrorsController < ActionController::API
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordInvalid, with: :record_exists

      def authenticate_current_user
        if current_user.nil?
          render json: { message: "Please login to access the resource" },
                 status: 401
        end
      end

      private

      def record_exists
        render json: { message: "Team(s) exists in the league!" },
               status: 400
      end

      def user_not_authorized
        render json: { message: "Cannot perform the action!" },
               status: 403
      end
    end
  end
end

