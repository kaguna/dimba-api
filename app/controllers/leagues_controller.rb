class LeaguesController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_league, only: %i(update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    leagues = League.all

    if leagues.empty?
      render json: { "error": "No leagues!" },
             status: :bad_request

    else
      render json: leagues, status: :ok
    end
  end

  def show
    league = League.find_by(id: params[:league_id])

    if league.blank?
      render json: { "error": "The league does not exist" },
             status: :bad_request

    else
      render json: league, status: :ok
    end
  end

  def create
    league = League.new(league_params)
    authorize league

    if league.save
      render json: league, status: :created

    else
      render json: league.errors, status: :unprocessable_entity
    end
  end

  def update
    if @league
      @league.update_attributes(league_params)
      render json: @league, status: :ok

    else
      render json: { errors: "The league does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @league
      @league.destroy
      render json: { message: "League was successfully deleted" },
             status: :ok

    else
      render json: { errors: "The league does not exist" },
             status: :bad_request
    end
  end

  private

  def set_league
    @league = League.find_by(id: params[:league_id])
    authorize @league
  end

  def league_params
    params.permit(
      :title,
      :season
    )
  end
end
