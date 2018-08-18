class EventsController < ApplicationController
  before_action :set_event, only: %i(update destroy)

  def index
    event = Event.where(fixtures_id: params[:fixture_id])
    if event.empty?
      render json: { "error": "No events for this game." },
             status: :bad_request
    else
      render json: event, status: :ok
    end

  end

  def create
    create_event = Event.new(event_params)

    if create_event.save
      render json: create_event, status: :created
    else
      render json: create_event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event
      @event.update_attributes(event_params)
      render json: @event, status: :ok
    else
      render json: { errors: "The events does not exist" },
             status: :bad_request
    end
  end

  def destroy
    if @event
      @event.destroy
      render json: { message: "Event was successfully deleted" }, status: :ok
    else
      render json: { errors: "The events does not exist" }, status: :bad_request
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end

  def event_params
    params.permit(
      :name,
      :description,
      :event_time,
      :teams_id,
      :players_id,
      :fixtures_id
    )
  end
end
