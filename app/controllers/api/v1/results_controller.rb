class Api::V1::ResultsController < Api::V1::ApplicationController
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
    add_fixture_results
  end

  def update
    authorize specific_result
    specific_result.update_attributes(result_params)
    render json: specific_result
  end

  def destroy
    authorize specific_result
    specific_result.destroy
  end

  private

  def add_fixture_results
    result_data.each do |attributes|
      result = Result.new(fixture_result_params(attributes))
      authorize result
      result.fixtures_id = params[:fixtures_id]
      result.save
    end
  end

  def result_data
    params.require(:fixture_results)
  end

  def fixture_result_params(attributes)
    attributes.permit(
        :teams_id,
        :total_goals,
        :points
    )
  end

  def specific_result
    @result = Result.find(params[:result_id])
  end

  def result_params
    params.permit(
        :fixtures_id,
        :teams_id,
        :total_goals,
        :points,
        :league_id
    )
  end
end
