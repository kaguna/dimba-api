module Api
  module V1
    class LeaguesTeamsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_league_teams, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show]

      def index
        render json: show_league_teams(params[:league_id])
      end

      def show
        render json: @league_team
      end

      def create
        league = League.find(params[:league_id])

        authorize league

        league.leagues_teams.create!(leagues_teams_params[:attributes])
        render json: league.leagues_teams
      end

      def update
        authorize @league_team
        @league_team.update_attributes(update_params)
        render json: @league_team
      end

      def destroy
        authorize @league_team
        @league_team.destroy
      end

      private

      def set_league_teams
        @league_team = LeaguesTeam.find(params[:id])
      end

      def leagues_teams_params
        params.require(:leagues_team).permit(attributes: [:team_id])
      end

      def update_params
        params.permit(:team_id)
      end

      def show_league_teams(league_id)
        league_teams ||= League.find(league_id).teams
      end
    end
  end
end
