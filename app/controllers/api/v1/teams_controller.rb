module Api
  module V1
    class TeamsController < ApplicationController
      before_action :authenticate_current_user!, except: %i(index show)
      before_action :set_team, only: %i(update destroy)
      after_action :verify_authorized, except: %i(index show)

      def index
        all_teams ||= Team.all
        render json: all_teams, status: :ok
      end

      def show
        render json: Team.find(params[:id])
      end

      def create
        create_team = Team.new(team_params)
        authorize create_team

        if create_team.save
          render json: create_team, status: :created

        else
          render json: create_team.errors, status: :unprocessable_entity
        end
      end

      def update
        if @team

          @team.update_attributes(team_params)
          render json: @team, status: :ok

        else
          render json: { errors: "The team does not exist"
          }, status: :bad_request
        end
      end

      def destroy
        if @team
          @team.destroy
          render json: { message: "Team was successfully deleted" },
                status: :ok

        else
          render json: { errors: "The team does not exist" },
                status: :bad_request
        end
      end

      private

      def set_team
        @team = Team.find_by(id: params[:id])
        authorize @team
      end

      def team_params
        params.permit(
            :name,
            :description,
            :location,
            :nickname,
            :coach_id
        )
      end
    end
  end
end
