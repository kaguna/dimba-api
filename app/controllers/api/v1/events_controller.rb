module Api
  module V1  
    class EventsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_event, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show]

      def index
        render json: Event.all
      end

      def show
        render json: @event
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
        authorize @event
        @event.update_attributes(event_params)
        render json: @event
      end

      def destroy
        authorize @event
        @event.destroy
      end

      private

      def set_event
        @event = Event.find(params[:id])
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
