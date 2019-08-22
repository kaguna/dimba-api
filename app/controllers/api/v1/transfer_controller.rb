class Api::V1::TransferController < ApplicationController
  before_action :authenticate_current_user, except: %i[index show]
  before_action :set_transfer, only: %i[show update destroy]
  after_action :verify_authorized, except: %i[index show]

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
      transfer_process(transfer_params['player_id'],
                       transfer_params['to_team_id'])
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

  def transfer_process(player_id, to_team_id)
    player = Player.find_by_id(player_id)
    player.update_columns(team_id: to_team_id)
  end
end
