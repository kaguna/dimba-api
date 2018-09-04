class FixturesController < ApplicationController

  def index
    fixtures = Fixture.all
    if fixtures.empty?
      render json: { errors: "No fixture available." },
             status: :bad_request

    else
      render json: fixtures, status: :ok
    end
  end

  def show
    fixture = Fixture.where(id: params[:fixture_id])
    if fixture.empty?
      render json: { error: "The fixture is not available." },
             status: :bad_request

    else
      render json: fixture, status: :ok
    end
  end

  def create
    create_fixture = Fixture.new(fixture_params)

    if create_fixture.save
      render json: create_fixture, status: :created

    else
      render json: create_fixture.errors,
             status: :unprocessable_entity
    end
  end

  def update
    edit_fixture = Fixture.find_by(id: params[:fixture_id])

    if edit_fixture
      edit_fixture.update_attributes(fixture_params)
      render json: edit_fixture, status: :ok

    else
      render json: { errors: "The fixture does not exist" },
             status: :bad_request
    end
  end

  def destroy
    delete_fixture = Fixture.find_by(id: params[:fixture_id])

    if delete_fixture
      delete_fixture.destroy
      render json: { message: "Fixture was successfully deleted" },
             status: :ok

    else
      render json: { errors: "The fixture does not exist" },
             status: :bad_request
    end
  end

  private

  def fixture_params
    params.permit(
        :home_team,
        :away_team,
        :season,
        :match_day
    )
  end
end
