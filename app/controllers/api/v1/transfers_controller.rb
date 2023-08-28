module Api
  module V1
    class TransfersController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show show_team_transfers]
      before_action :set_transfer, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show show_team_transfers]

      def index
        render json: Transfer.all
      end

      def show
        render json: @transfer
      end

      def create
        transfer = Transfer.new(transfer_params)
        authorize transfer

        if transfer.save
          # transfer_process(transfer_params['player_id'],
          #                 transfer_params['to_team_id'])
          render json: transfer, status: :created

        else
          render json: transfer.errors,
                status: :unprocessable_entity
        end
      end

      def update
        authorize @transfer
        @transfer.update_attributes(transfer_params)
        render json: @transfer
      end

      def destroy
        authorize @transfer
        @transfer.destroy
      end

      def show_team_transfers
        render json: get_team_transfers, scope: { current_user: current_user }, status: :ok
      end

      private

      def set_transfer
        @transfer = Transfer.find(params[:id])
      end

      def transfer_params
        params.permit(
          :from_team_id,
          :to_team_id,
          :player_id,
          :transfer_comment,
          :transfer_budget,
          :contract_time
        )
      end

      def get_team_transfers
        team = Team.find(params[:team_id])
        team.from_team_transfers.or(team.to_team_transfers).order(created_at: :desc)
      end

      # def transfer_process(player_id, to_team_id)
      #   player = Player.find_by_id(player_id)
      #   player.update_columns(team_id: to_team_id)
      # end
    end
  end
end
