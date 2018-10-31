require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe LeaguesTeam, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:teams) { create_list(:team, 10) }

  let!(:league) { create(:league) }

  let(:league_id) { league.id }

  let(:league_teams) do
    teams.each do |team|
      create(:league_teams,
             league_id: league.id,
             team_id: team.id
      )
    end
    LeaguesTeam.all
  end

  let(:league_team_id) { league_teams.first.id }

  let(:league_teams_params) {
    {
      league_teams: [
        {
          league_id: league.id,
          team_id: teams.first.id
        },
        {
          league_id: league.id,
          team_id: teams.second.id
        }
      ]
    }
  }

  let(:num_teams) { league_teams_params[:league_teams].size }

  describe "POST /league/:league_id/league_teams" do
    context "when the request is valid" do
      before do
        post "/league/#{league_id}/league_teams",
             headers: authenticated_header(user),
             params: league_teams_params
      end

      it "creates a new fixture" do
        expect(json["message"]).to eq("#{num_teams} team(s) added to the league")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /league/:league_id/league_teams" do
    context "when the request is valid" do
      let!(:league_teams) do
        teams.each do |team|
          create(:league_teams,
                 league_id: league.id,
                 team_id: team.id
          )
        end
        LeaguesTeam.all
      end

      before do
        get "/league/#{league_id}/league_teams"
      end

      it "returns a list with 10 hash" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:league_team_id) { 1000 }
      before do
        get "/league/#{league_id}/league_teams/#{league_team_id}"
      end

      it "returns an error message" do
        expect(json["error"]).to eq("The league team is not available.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /league/:league_id/league_teams/:league_team_id" do
    context "when the request is valid" do
      before do
        delete "/league/#{league_id}/league_teams/#{league_team_id}",
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Team was removed from league")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:league_team_id) { 0 }

      before do
        delete "/league/#{league_id}/league_teams/#{league_team_id}",
               headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The team does not exist in the league")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /league/:league_id/league_teams/:league_team_id" do
    context "when the request is valid" do
      before do
        put "/league/#{league_id}/league_teams/#{league_team_id}",
            headers: authenticated_header(user)
      end

      it "returns a hash with 5 keys" do
        expect(json.size).to eq 5
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:league_team_id) { 0 }

      before do
        put "/league/#{league_id}/league_teams/#{league_team_id}",
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The team does not exist in the league")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
