module Api
  module V1
    class ErrorsController < ActionController::API
      # protect_from_forgery

      attr_reader :current_user

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordNotUnique, with: :already_exists
      rescue_from RuntimeError, with: :invalid
      rescue_from JWT::DecodeError, with: :user_not_authorized

      rescue_from ActiveRecord::RecordInvalid do |e|
        invalid_record(e)
      end

      private

      def authenticate_current_user!
        if @current_user.nil?
          render json: { message: "Please login to access the resource" },
                status: 401
        end
      end

      def already_exists
        render json: { message: "Duplicate not allowed" }, status: 302
      end

      def not_found
        render json: {}, status: 404
      end

      def user_not_authorized
        render json: { message: "Cannot perform the action!" },
              status: 403
      end

      def invalid_record(exception)
        render json: { error: exception.message }, status: :bad_request
      end

      def invalid
        render json: { error: 'Invalid credentials!' }, status: :unauthorized
      end

      def authorize_api_request
        @current_user = (AuthorizeRequest.new(request.headers).call)[:user]
      end
    end
  end
end
