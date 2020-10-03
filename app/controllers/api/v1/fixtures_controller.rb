module Api
  module V1   
    class FixturesController < ApplicationController
      include FixturesConcern
      before_action :authenticate_current_user!, except: %i(index show show_team_home_fixtures show_team_away_fixtures)
      before_action :set_fixture, only: %i(show update destroy)
      after_action :verify_authorized, except: %i(index show show_team_home_fixtures show_team_away_fixtures)

      def generate_fixture
        authorize Fixture
        pre_fixtures = generate(params[:league_id], params[:season_id])
        render json: {matches: pre_fixtures.length, pre_fixtures: pre_fixtures}, status: :ok
      end

      def show_team_home_fixtures
        render json: Fixture.team_home_fixtures(params[:team_id])
      end

      def show_team_away_fixtures
        render json: Fixture.team_away_fixtures(params[:team_id])
      end

      def index
        fixtures = Fixture.league_fixtures(league_id: params[:league_id])
        render json: fixtures
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
        if (fixture_exists?)
          require_fixtures.each do |attributes|
            @s_fixtures = Fixture.new(fixture_params(attributes))
            @s_fixtures.save!
          end
          render json: {message: "#{require_fixtures.length} matches added."}, status: :created
        else 
          render json: {}, status: :found 
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
        @fixture = Fixture.find_by(id: params[:match_id])
      end

      def fixture_exists?
        Fixture.find_by(league_id: params[:league_id], season_id: params[:season_id]).nil?
      end

      def fixture_params
        params.require(:fixtures).map do |p|
          p.permit(:home_team_id, :away_team_id, :season_id, :match_day)
        end
      end

      def fixture_params(attributes)
        attributes.permit(:home_team_id, :away_team_id, :match_day).to_h.merge!(
          league_id: params[:league_id],
          season_id: params[:season_id]
        )
      end

      def require_fixtures
        params.require(:fixtures)
      end

      def update_params
        params.permit(
          :center_referee_id,
          :right_side_referee_id,
          :left_side_referee_id,
          :match_day
        )
      end
    end
  end
end
