class FixturesController < ApplicationController
  include FixturesControllerHelper
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_fixture, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    fixtures = Fixture.where(league_id: params[:league_id])

    if fixtures
      render json: fixtures, status: :ok
    else
      render json: { errors: "No fixture available." },
             status: :bad_request
    end
  end

  def generate_fixture
    authorize self
    render json: generate(fixture_params[:league_id]), status: :ok
  end

  def show
    fixture = Fixture.where(id: params[:fixture_id],
                            league_id: params[:league_id])

    if fixture.empty?
      render json: { error: "The fixture is not available." },
             status: :bad_request
    else
      render json: fixture, status: :ok
    end
  end

  def create
    create_fixture = Fixture.new(fixture_params)
    authorize create_fixture

    if create_fixture.save
      render json: create_fixture, status: :created

    else
      render json: create_fixture.errors,
             status: :unprocessable_entity
    end
  end

  def update
    if @fixture
      @fixture.update_attributes(fixture_params)
      render json: @fixture, status: :ok

    else
      render json: { errors: "The fixture does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @fixture
      @fixture.destroy
      render json: { message: "Fixture was successfully deleted" },
             status: :ok

    else
      render json: { errors: "The fixture does not exist" },
             status: :bad_request
    end
  end

  private

  def set_fixture
    @fixture = Fixture.find_by(id: params[:fixture_id],
                               league_id: params[:league_id])
    authorize @fixture
  end

  def fixture_params
    params.permit(
      :home_team,
      :away_team,
      :season,
      :league_id,
      :match_day
    )
  end
end
