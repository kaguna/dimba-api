module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_current_user, except: %i(index show)
      before_action :set_event, only: %i(update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        event = Event.all
        if event.empty?
          render json: { "error": "No event found!" },
                 status: :bad_request

        else
          render json: event, status: :ok
        end
      end

      def show
        event = Event.find_by_id(params[:event_id])

        if event.nil?
          render json: { "error": "The event is not found!" },
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
        if @event.nil?
          render json: { errors: "The event does not exist" },
                 status: :bad_request

        else
          @event.update_attributes(event_params)
          render json: @event, status: :ok
        end
      end

      def destroy
        if @event.nil?
          render json: { errors: "The event does not exist" },
                 status: :bad_request

        else
          @event.destroy
          render json: { message: "Event was successfully deleted" },
                 status: :ok
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
  end
end
