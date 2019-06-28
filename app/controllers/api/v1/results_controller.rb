class Api::V1::ResultsController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :specific_result, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    render json: Result.all, status: :ok
  end

  def show
    render json: specific_result, status: :ok
  end

  def create
    result = Result.create!(result_params)
    authorize result
    render json: result, status: :created
  end

  def update
    authorize specific_result
    specific_result.update_attributes(result_params)
    render json: specific_result
  end

  def destroy
    authorize specific_result
    specific_result.destroy
    render json: {}, status: :ok
  end

  private

  def specific_result
    @result = Result.find(params[:result_id])
  end

  def result_params
    params.permit(
        :fixture_id,
        :home_goals,
        :away_goals
    )
  end
end
