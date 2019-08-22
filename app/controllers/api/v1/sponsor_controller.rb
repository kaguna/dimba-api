class Api::V1::SponsorController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_sponsor, only: %i(show update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    render json: Sponsor.all
  end

  def show
    render json: @sponsor
  end

  def create
    sponsor = Sponsor.new(sponsor_params)
    authorize sponsor

    if sponsor.save
      render json: sponsor, status: :created

    else
      render json: sponsor.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @sponsor
    @sponsor.update_attributes(sponsor_params)
    render json: @sponsor
  end

  def destroy
    authorize @sponsor
    @sponsor.destroy
  end

  private

  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.permit(
      :name,
      :description,
      :contacts
    )
  end
end
