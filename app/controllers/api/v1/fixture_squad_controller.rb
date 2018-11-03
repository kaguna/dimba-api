module Api
  module V1
    class FixtureSquadController < ApplicationController
      before_action :authenticate_current_user, except: %i(index show)
      before_action :set_fixture_squad, only: %i(update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        fixture_squad = FixtureSquad.where(fixtures_id: params[:fixtures_id],
                                          teams_id: params[:teams_id]
        )

        if fixture_squad.empty?
          render json: { errors: "No squad for this match." },
                status: :bad_request

        else
          render json: fixture_squad, status: :ok
        end
      end

      def show
        squad_player = FixtureSquad.where(id: params[:fixture_squad_id])

        if squad_player.empty?
          render json: { error: "The player is not in the squad." },
                status: :bad_request

        else
          render json: squad_player, status: :ok
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
        if @fixture_squad
          @fixture_squad.update_attributes(update_params)
          render json: @fixture_squad, status: :ok

        else
          render json: { errors: "The player is not in the squad." },
                status: :bad_request
        end
      end

      def destroy
        if @fixture_squad
          @fixture_squad.destroy
          render json: { message: "Players removed from the squad." },
                status: :ok

        else
          render json: { errors: "The player is not in the squad." },
                status: :bad_request
        end
      end

      private

      def create_fixture_squad
        players_paramaters.each do |attributes|
          fixture_squad = FixtureSquad.new(players_params(attributes))
          authorize fixture_squad
          fixture_squad.save!
        end
      end

      def set_fixture_squad
        @fixture_squad = FixtureSquad.find_by(id: params[:fixture_squad_id])
        authorize @fixture_squad
      end

      def players_params(attributes)
        attributes.permit(:players_id).to_h.merge!(
          fixtures_id: params[:fixtures_id],
          teams_id: params[:teams_id]
        )
      end

      def players_paramaters
        params.require(:fixture_squad)
      end

      def update_params
        params.permit(:teams_id, :fixtures_id, :players_id)
      end
    end
  end
end
