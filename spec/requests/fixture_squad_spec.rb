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

<<<<<<< HEAD
  let!(:season) { create(:season) }

=======
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
  let!(:fixture) do
    create(:fixture,
           home_team: teams.last.id,
           away_team: teams.first.id,
<<<<<<< HEAD
           season_id: season.id,
=======
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
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
             fixtures_id: fixture.id,
             teams_id: teams.first.id,
             players_id: player.id
      )
    end
    FixtureSquad.all
  end

  let(:fixture_squad_params) {
    {
      fixture_squad: [
        {
          players_id: players.first.id
        },
        {
          players_id: players.second.id
        }
      ]
    }
  }

  let(:fixture_id) { fixture.id }
  let(:league_id) { league.id }
  let(:team_id) { teams.first.id }
  let(:squad_id) { fixture_squad.first.id }
  let(:num_players) { fixture_squad_params[:fixture_squad].size }

  describe "POST league/:league_id/fixture/:fixture_id/team/team_id/squad" do
    context "when the request is valid" do
      before do
<<<<<<< HEAD
        post api_v1_add_fixture_squad_path(leagues_id: league_id,
           fixtures_id: fixture_id,
           teams_id: team_id
           ),
            headers: authenticated_header(user),
            params: fixture_squad_params
=======
        post "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad",
             headers: authenticated_header(user),
             params: fixture_squad_params
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end

      it "creates a new fixture squad" do
        expect(json["message"]).to eq("#{num_players} player(s) added to game")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET league/:league_id/fixture/:fixture_id/team/team_id/squad" do
    context "when the request is valid" do

      before do
<<<<<<< HEAD
        get api_v1_fixture_squads_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id
          )
=======
        get "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad"
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 13
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:squad_id) { 1000 }
      let(:url) do
<<<<<<< HEAD
        api_v1_fixture_squad_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id,
          fixture_squad_id: squad_id
          )
=======
        "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad/#{squad_id}"
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end

      before do
        get url
      end

      it "returns an error message" do
        expect(json["error"]).to eq("The player is not in the squad.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE fixture/:fixture_id/team/team_id/squad/:squad_id" do
    context "when the request is made by an admin" do
      before do
<<<<<<< HEAD
        delete api_v1_delete_fixture_squad_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id,
          fixture_squad_id: squad_id
          ),
=======
        delete "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad/#{squad_id}",
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Players removed from the squad.")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:squad_id) { 1000 }
      let(:url) do
<<<<<<< HEAD
        api_v1_delete_fixture_squad_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id,
          fixture_squad_id: squad_id
        )
=======
        "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad/#{squad_id}"
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end

      before do
        delete url, headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The player is not in the squad.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT fixture/:fixture_id/team/team_id/squad/:squad_id" do
    context "when the request is valid" do
      let(:url) do
<<<<<<< HEAD
        api_v1_edit_fixture_squad_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id,
          fixture_squad_id: squad_id
        )
=======
        "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad/#{squad_id}"
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end
      before do
        put url, headers: authenticated_header(user)
      end

      it "returns a hash with 7 keys" do
        expect(json.size).to eq 7
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:squad_id) { 1000 }
      let(:url) do
<<<<<<< HEAD
        api_v1_edit_fixture_squad_path(leagues_id: league_id,
          fixtures_id: fixture_id,
          teams_id: team_id,
          fixture_squad_id: squad_id
        )
=======
        "/league/#{league_id}/fixture/#{fixture_id}/team/#{team_id}/squad/#{squad_id}"
>>>>>>> feat(fixtureSquadPage): Enable users perform CRUD operations  on fixture_squad. (#47)
      end

      before do
        put url, headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The player is not in the squad.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
