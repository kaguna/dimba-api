module Api
  module V1   
    class FixturesController < ApplicationController
      include FixturesConcern
      before_action :authenticate_current_user, except: %i(index show)
      before_action :set_fixture, only: %i(show update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        render json: show_league_fixtures(params[:league_id])
      end

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
        create_fixtures
        render json: {
          message: "#{fixtures_paramaters.size} games successfully created"
        }, status: :created
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

      def create_fixtures
        fixtures_paramaters.each do |attributes|
          fixture = Fixture.new(fixture_params(attributes))
          authorize fixture
          fixture.league_id = params[:league_id]
          fixture.save
        end
      end

      def set_fixture
        @fixture = Fixture.find_by(id: params[:id],
                                  league_id: params[:league_id])
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

      def show_league_fixtures(league_id)
        team_players ||= League.find(league_id).fixtures
      end
    end
  end
end
