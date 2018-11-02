class EventsController < ApplicationController
  before_action :authenticate_current_user, except: [:index, :show]
  before_action :set_event, only: %i(update destroy)
  after_action :verify_authorized, except: [:index, :show]

  def index
    events = Event.all
    if events.empty?
      render json: { "error": "No events found." },
             status: :bad_request

    else
      render json: events, status: :ok
    end
  end

  def show
    event = Event.where(id: params[:event_id])
    if event.empty?
      render json: { "error": "The event does not exist." },
             status: :bad_request

    else
      render json: event, status: :ok
    end
  end

  def create
    event = Event.new(event_params)
    authorize event

    if event.save
      render json: event, status: :created

    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event
      @event.update_attributes(event_params)
      render json: @event, status: :ok

    else
      render json: { errors: "The event does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @event
      @event.destroy
      render json: { message: "Event was successfully deleted" }, status: :ok

    else
      render json: { errors: "The event does not exist" }, status: :bad_request
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:event_id])
    authorize @event
  end

  def event_params
    params.permit(
      :name,
      :description
    )
  end
end
