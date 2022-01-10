require "rails_helper"
require "./spec/support/request_helper"
require "./spec/support/authentication_helper"

RSpec.describe FixtureSquad, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:teams) do
    create_list(:team, 10)
  end

  let!(:league) { create(:league) }

  let!(:season) { create(:season) }

  let!(:fixture) do
    create(:fixture,
          home_team_id: teams.last.id,
          away_team_id: teams.first.id,
          season_id: season.id,
          league_id: league.id
    )
  end

  let!(:players) do
    create_list(:player, 13,
                team_id: teams.first.id
    )
  end

  let!(:fixture_squad) do
    players.each do |player|
      create(:fixture_squad,
            fixture_id: fixture.id,
            team_id: teams.first.id,
            player_id: player.id
      )
    end
    FixtureSquad.all
  end

  let(:fixture_squad_params) {
    {
      fixture_squad: [
        {
          player_id: players.first.id
        },
        {
          player_id: players.last.id
        }
      ]
    }
  }

  let(:fixture_id) { fixture.id }
  let(:league_id) { league.id }
  let(:team_id) { teams.first.id } 
  let(:squad_id) { fixture_squad.first.id }
  let(:num_players) { fixture_squad_params[:fixture_squad].size }

  xdescribe "POST league/:league_id/fixture/:fixture_id/team/team_id/squad" do
    context "when the request is valid" do
      before do
        post api_v1_league_fixture_team_fixture_squad_index_path(league_id: league_id,
                                          fixture_id: fixture_id,
                                          team_id: team_id),
            headers: authenticated_header(user),
            params: fixture_squad_params
      end

      it "creates a new fixture squad" do
        expect(json["message"]).to eq("#{num_players} player(s) added to game")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  xdescribe "GET league/:league_id/fixture/:fixture_id/team/team_id/squad" do
    context "when the request is valid" do

      before do
        get api_v1_league_fixture_team_fixture_squad_index_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id
          )
      end

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 13
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_squad_id) { 100 }
      let(:url) do
        api_v1_league_fixture_team_fixture_squad_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id,
          id: fixture_squad_id
          )
      end

      before do 
        get url
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe "DELETE fixture/:fixture_id/team/team_id/squad/:squad_id" do
    context "when the request is made by an admin" do
      before do
        delete api_v1_league_fixture_team_fixture_squad_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id,
          id: squad_id
          ),
              headers: authenticated_header(user)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when the request is invalid" do
      let!(:squad_id) { 1000 }
      let(:url) do
        api_v1_league_fixture_team_fixture_squad_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id,
          id: squad_id
        )
      end

      before do
        delete url, headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe "PUT fixture/:fixture_id/team/team_id/squad/:squad_id" do
    context "when the request is valid" do
      let(:url) do
        api_v1_league_fixture_team_fixture_squad_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id,
          id: squad_id
        )
      end
      before do
        put url, headers: authenticated_header(user)
      end

      it "returns a hash with 4 keys" do
        expect(json['squad'].size).to eq 4
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:squad_id) { 1000 }
      let(:url) do
        api_v1_league_fixture_team_fixture_squad_path(league_id: league_id,
          fixture_id: fixture_id,
          team_id: team_id,
          id: squad_id
        )
      end

      before do
        put url, headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
