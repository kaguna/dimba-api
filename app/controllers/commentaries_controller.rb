class CommentariesController < ApplicationController
  before_action :authenticate_current_user, except: [:index]
  before_action :set_commentary, only: %i(update destroy)
  after_action :verify_authorized, except: [:index]

  def index
    commentary = Commentary.where(fixtures_id: params[:fixture_id])

    if commentary.empty?
      render json: { "error": "No commentary for this game." },
             status: :bad_request
    else
      render json: commentary, status: :ok
    end
  end

  def create
    commentary = Commentary.new(commentary_params)
    authorize commentary

    if commentary.save
      render json: commentary, status: :created
    else
      render json: commentary.errors, status: :unprocessable_entity
    end
  end

  def update
    if @commentary
      @commentary.update_attributes(commentary_params)
      render json: @commentary, status: :ok
    else
      render json: { errors: "The commentary does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @commentary
      render json: { message: "Commentary was successfully deleted" },
             status: :ok
    else
      render json: { errors: "The commentary does not exist" },
             status: :bad_request
    end
  end

  private

  def set_commentary
    @commentary = Commentary.find_by(id: params[:commentary_id])
    authorize @commentary
  end

  def commentary_params
    params.permit(
      :name,
      :description,
      :commentary_time,
      :teams_id,
      :players_id,
      :fixtures_id
    )
  end
end
