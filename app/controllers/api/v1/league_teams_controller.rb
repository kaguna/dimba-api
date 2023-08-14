module Api
  module V1
    class LeagueTeamsController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show create]
      before_action :set_league_teams, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show create]

      def index
        teams = LeaguesTeam.league_season_teams(league_id: params[:league_id], season_id: params[:season_id])
        render json: {count: teams.length, league_season_teams: teams.map{|team| LeaguesTeamSerializer.new(team)}}
      end

      def show
        render json: @league_team
      end

      def create
        require_league_teams.each do |attributes|
          @lst = LeaguesTeam.new(league_teams_params(attributes))
          authorize @lst
          @lst.save!
        end
        render json: {message: "#{require_league_teams.length} teams added."}, status: :created
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

      def league_teams_params(attributes)
        attributes.permit(:team_id).to_h.merge!(
          league_id: params[:league_id],
          season_id: params[:season_id]
        )
      end

      def require_league_teams
        params.require(:league_teams)
      end

      def update_params
        params.permit(:team_id)
      end
    end
  end
end
