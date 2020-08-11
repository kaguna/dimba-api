module Api
  module V1
    class CommentariesController < ApplicationController
      before_action :authenticate_current_user!, only: %i(create update destroy)
      before_action :set_commentary, only: %i(show update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        commentaries = Commentary.match_commentaries(params[:match_id])
        render json:  commentaries
      end

      def show
        render json: @commentary
      end

      def create
        commentary = Commentary.new(commentary_params)
        authorize commentary

        if commentary.save!
          render json: commentary, status: :created
        else
          render json: commentary.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @commentary
        @commentary.update_attributes(commentary_params)
        render json: @commentary
      end

      def destroy
        authorize @commentary
        @commentary.destroy
      end

      private

      def set_commentary
        @commentary = Commentary.find(params[:id])
      end

      def commentary_params
        params.permit(
          :event_id,
          :description,
          :commentary_time,
          :team_id,
          :player_id,
          :fixture_id
        )
      end
    end
  end
end
