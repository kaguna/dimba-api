module Api
  module V1
    class FixtureSquadsController < ApplicationController
      before_action :authenticate_current_user!, except: %i(index show)
      before_action :set_fixture_squad, only: %i(show update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        fixture_squad = FixtureSquad.match_squads(match_id: params[:match_id])
        render json: fixture_squad, status: :ok
      end

      def show
        render json: @fixture_squad
      end

      def add_first_11
        authorize FixtureSquad.new
        selected_11 = players_paramaters.length
        if selected_11 > 11 ||  selected_11 < 7
          render json: {error: "Starting lineup can only be less 11 and greater than 7 !" },
                        status: :bad_request
        else
          FixtureSquad.transaction do
            players_paramaters.each do |attributes|
              fixture_squad = FixtureSquad.find(attributes["id"])
              fixture_squad.update!(playing: true)
            end
          end
        end
      end

      def create
        create_fixture_squad
        render json:
                  {
                    message: "#{players_paramaters.size} player(s) added to game"
                  }, status: :created
      end

      def update
        authorize @fixture_squad
        @fixture_squad.update_attributes(update_params)
        render json: @fixture_squad
      end

      def destroy
        authorize @fixture_squad
        @fixture_squad.destroy
      end

      private

      def create_fixture_squad
        players_paramaters.each do |attributes|
          fixture_squad = FixtureSquad.new(attributes)
          authorize fixture_squad
          fixture_squad.save!
        end
      end

      def set_fixture_squad
        @fixture_squad = FixtureSquad.find(params[:id])
      end

      def players_paramaters
        params.require(:fixture_squad).map do |p|
          p.permit(:player_id, :fixture_id, :team_id, :id)
        end
      end

      def update_params
        params.permit(:team_id, :fixture_id, :player_id)
      end
    end
  end
end
