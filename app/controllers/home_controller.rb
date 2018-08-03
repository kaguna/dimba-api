class HomeController < ApplicationController

  def show_all_teams
    render json: Team.all
  end

end
