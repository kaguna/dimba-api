class ErrorsController < ActionController::API
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_current_user
    if current_user.nil?
      render json: { message: "Please login to access the resource" },
             status: 401
    end
  end

  private

  def user_not_authorized
    render json: { message: "Cannot perform the action!" },
           status: 403
  end
end
