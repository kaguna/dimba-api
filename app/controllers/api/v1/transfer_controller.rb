class Api::V1::TransferController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_transfer, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    all_transfers = Transfer.all
    if all_transfers.empty?
      render json: { errors: "No transfers available." },
             status: :bad_request

    else
      render json: all_transfers, status: :ok
    end
  end

  def show
    player_transfer = Transfer.find_by(player_id: params[:player_id])
    if player_transfer
      render json: player_transfer, status: :ok

    else
      render json: { error: "The player has no transfer history." },
             status: :bad_request
    end
  end

  def transfer_process(player, to_team)
    player = Player.find_by_id(player)
    player.update_columns(team_id: to_team)
  end

  def create
    transfer = Transfer.new(transfer_params)
    authorize transfer

    if transfer.save
      transfer_process(transfer_params["player_id"],
                       transfer_params["to_team_id"])
      render json: transfer, status: :created

    else
      render json: transfer.errors,
             status: :unprocessable_entity
    end
  end

  def update
    if @transfer
      @transfer.update_attributes(transfer_params)
      render json: @transfer, status: :ok

    else
      render json: { errors: "The transfer does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @transfer
      @transfer.destroy
      render json: { message: "Transfer was successfully deleted" },
             status: :ok

    else
      render json: { errors: "The transfer does not exist" },
             status: :bad_request
    end
  end

  private

  def set_transfer
    @transfer = Transfer.find_by(id: params[:transfer_id])
    authorize @transfer
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
end
