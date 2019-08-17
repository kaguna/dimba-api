class Api::V1::FixturesController < ApplicationController
  include FixturesConcern
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_fixture, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    fixtures = Fixture.where(league_id: params[:league_id])

    if fixtures.empty?
      render json: { errors: "No fixtures available." },
             status: :bad_request

    else
      render json: fixtures, status: :ok
    end
  end

  def generate_fixture
    authorize Fixture.new
    render json: generate(params[:league_id]), status: :ok
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
    create_fixtures
    render json: {
      message: "#{fixtures_paramaters.size} games successfully created"
    }, status: :created
  end

  def update
    if @fixture
      @fixture.update_attributes(update_params)
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

  def create_fixtures
    fixtures_paramaters.each do |attributes|
      fixture = Fixture.new(fixture_params(attributes))
      authorize fixture
      fixture.league_id = params[:league_id]
      fixture.save
    end
  end

  def set_fixture
    @fixture = Fixture.find_by(id: params[:fixture_id],
                               league_id: params[:league_id])
    authorize @fixture
  end

  def fixture_params(attributes)
    attributes.permit(
      :home_team_id,
      :away_team_id,
      :season_id
    )
  end

  def fixtures_paramaters
    params.require(:fixtures)
  end

  def update_params
    params.permit(
        :center_referee,
        :right_side_referee,
        :left_side_referee,
        :match_day
    )
  end
end
