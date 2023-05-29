module Api
  module V1
    class PlayersController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show search_player]
      before_action :set_player, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show search_player]

      def index
        render json: show_team_players(params[:team_id])
      end

      def show
        render json: @player
      end

      def search_player
        players = Player.search(params[:q])
        render json: players, status: :ok
      end

      def create
        create_player = Player.new(player_params)
        authorize create_player

        if create_player.save
          render json: create_player, status: :created

        else
          render json: create_player.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @player
        if @player
          @player.update_attributes(player_params)
          render json: @player, status: :ok

        else
          render json: { errors: 'The player does not exist' },
                 status: :bad_request
        end
      end

      def destroy
        authorize @player
        if @player
          @player.destroy
          render json: { message: 'Player was successfully deleted' }, status: :ok

        else
          render json: { errors: 'The player does not exist' }, status: :bad_request
        end
      end

      private

      def set_player
        @player = Player.find_by(team_id: params[:team_id], id: params[:id])
      end

      def player_params
        params.permit(
          :first_name,
          :second_name,
          :last_name,
          :nick_name,
          :id_number,
          :dob,
          :phone_number,
          :team_id
        )
      end

      def show_team_players(team_id)
        team_players ||= Team.find(team_id).players
      end
    end
  end
end
