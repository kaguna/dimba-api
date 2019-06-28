class Api::V1::SponsorController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_sponsor, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    sponsors = Sponsor.all

    if sponsors.empty?
      render json: { errors: "No sponsors found!" },
             status: :bad_request

    else
      render json: sponsors, status: :ok
    end
  end

  def show
    sponsor = Sponsor.find_by_id(params[:sponsor_id])

    if sponsor
      render json: sponsor, status: :ok

    else
      render json: { errors: "The sponsor does not exist" },
             status: :bad_request
    end
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
    if @sponsor
      @sponsor.update_attributes(sponsor_params)
      render json: @sponsor, status: :ok

    else
      render json: { errors: "The sponsor does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @sponsor
      @sponsor.destroy
      render json: { message: "Sponsor was successfully deleted" }, status: :ok

    else
      render json: { errors: "The sponsor does not exist" }, status: :bad_request
    end
  end

  private

  def set_sponsor
    @sponsor = Sponsor.find_by(id: params[:sponsor_id])
    authorize @sponsor
  end

  def sponsor_params
    params.permit(
      :name,
      :description,
      :contacts
    )
  end
end
