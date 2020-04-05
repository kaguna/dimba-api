module Api
  module V1
    class ErrorsController < ActionController::API
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def authenticate_current_user
        if current_user.nil?
          render json: { message: "Please login to access the resource" },
                status: 401
        end
      end

      private

      def not_found
        render json: {}, status: 404
      end

      def user_not_authorized
        render json: { message: "Cannot perform the action!" },
              status: 403
      end
    end
  end
end
