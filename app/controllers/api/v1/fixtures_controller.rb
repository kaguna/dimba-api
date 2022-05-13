# frozen_string_literal: true

module Api
  module V1
    class FixturesController < ApplicationController
      include FixturesConcern
      before_action :authenticate_current_user!, except: %i[
        index
        show
        show_team_home_fixtures
        show_team_away_fixtures
        h2h_matches
      ]
      before_action :set_fixture, only: %i[show update destroy]
      before_action :gen_matches, only: %i[generate_fixture]
      after_action :verify_authorized, except: %i[
        index
        show
        show_team_home_fixtures
        show_team_away_fixtures
        h2h_matches
      ]

      def generate_fixture
        authorize Fixture
        render json: { matches: @pre_fixtures.length, pre_fixtures: assign_match_day }, status: :ok
      end

      def show_team_home_fixtures
        render json: TeamSeasonLeagueGamesQuery.call('home_team_id', params[:team_id], false), relevant: true
      end

      def show_team_away_fixtures
        render json: TeamSeasonLeagueGamesQuery.call('away_team_id', params[:team_id], false), relevant: true
      end

      def h2h_matches
        teams_ids = params[:team_id].split(',')
        render json: Fixture.h2h_team_matches(teams_ids, params[:per_page], params[:page])
      end

      def index
        fixtures = Fixture.league_fixtures(league_id: params[:league_id], per_page: params[:per_page], page: params[:page])
        serialized_fxts = ActiveModel::Serializer::CollectionSerializer.new(
          fixtures[:fixtures],
          serializer: FixtureSerializer
        ).as_json
        grouped_fixtures = serialized_fxts.group_by { |x| x[:match_day].to_date }
        render json: { count: fixtures[:count], fixtures: grouped_fixtures.to_a }
      end

      def show
        if @fixture.nil?
          render json: { error: 'The fixture is not available.' },
                 status: :bad_request
        else
          render json: @fixture, status: :ok
        end
      end

      def create
        authorize Fixture
        count = 0
        require_fixtures.each do |attributes|
          h = fixture_params(attributes)
          param = { home_team_id: h['away_team_id'], away_team_id: h['home_team_id'], league_id: h['league_id'], season_id: h['season_id'] }
          next if fixture_exists?(h.except(:match_day)) || fixture_exists?(param)
          # When a team joins the league after fixtures have been generated.(Home OR away only)
          # TODO: Avoid dups when generating fixtures for team that joined later.
          count += 1
          @s_fixtures = Fixture.new(h)
          @s_fixtures.save!
        end
        render json: { message: "#{count} matches added." }, status: :created
      end

      def update
        authorize @fixture
        if @fixture
          @fixture.update_attributes(update_params)
          render json: @fixture, status: :ok

        else
          render json: { errors: 'The fixture does not exist' },
                 status: :bad_request
        end
      end

      def destroy
        authorize @fixture
        if @fixture
          @fixture.destroy
          render json: { message: 'Fixture was successfully deleted' },
                 status: :ok

        else
          render json: { errors: 'The fixture does not exist' },
                 status: :bad_request
        end
      end

      private

      def set_fixture
        @fixture = Fixture.find_by(id: params[:match_id])
      end

      def fixture_exists?(attributes)
        Fixture.exists?(attributes)
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

      def gen_matches
        @pre_fixtures ||= generate(params[:league_id], params[:season_id], params[:home_away])
      end

      def list_match_dates
        # Take some of the variables in the config
        matches_per_day = 5 # TBD by league official. Future work
        all_matches_duration = (@pre_fixtures.length / matches_per_day).floor + 1
        today = DateTime.now.change(hour: 10) # TBD by league official. Future work
        (today..today + all_matches_duration.weeks).group_by(&:wday)[0] # TBD by league official. Future work
      end

      def assign_match_day
        @pre_fixtures.each_slice(4).each_with_index do |matches, i| # TBD by league official. Future work
          match_date = list_match_dates[i]
          matches.each do |match|
            match[:match_day] = match_date
            match_date += 1.75.hours
          end
        end
        @pre_fixtures
      end
    end
  end
end
