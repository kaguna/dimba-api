module Api
  module V1   
    class FixturesController < ApplicationController
      include FixturesConcern
      before_action :authenticate_current_user, except: %i(index show)
      before_action :set_fixture, only: %i(show update destroy)
      after_action :verify_authorized, except: %i(show)

      def generate_fixture
        authorize Fixture.new
        render json: generate(params[:league_id]), status: :ok
      end

      def show
        if @fixture.nil?
          render json: { error: "The fixture is not available." },
                status: :bad_request
        else
          render json: @fixture, status: :ok
        end
      end

      def create
        authorize Fixture
        league = League.find(params[:league_id])
        league.fixtures.new(fixture_params)

        if league.valid?
          league.save
          render json:  { message: "Created" },
                        status: :created
        else
          render json:  { errors: "Invalid fixture" },
                  status: :bad_request
        end
      end

      def update
        authorize @fixture
        if @fixture
          @fixture.update_attributes(update_params)
          render json: @fixture, status: :ok

        else
          render json: { errors: "The fixture does not exist" },
                status: :bad_request
        end
      end

      def destroy
        authorize @fixture
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
        @fixture = Fixture.find_by(id: params[:id])
      end

      def fixture_params
        params.require(:fixtures).map do |p|
          p.permit(:home_team_id, :away_team_id, :season_id, :match_day)
        end
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
  end
end
