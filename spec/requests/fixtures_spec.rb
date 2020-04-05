require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe Fixture, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:ref_role) { create(:role, name: "Referee") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:user_ref) do
    create_list(:user, 3,
                role_id: ref_role.id)
  end

  let!(:team) { create_list(:team, 10) }

  let!(:league) { create(:league) }

  let!(:season) { create(:season) }

  let!(:fixtures) do
    create_list(
      :fixture, 10,
      home_team_id: team.last.id,
      away_team_id: team.first.id,
      league_id: league.id,
      season_id: season.id,
    )
  end


  let(:league_id) { league.id }

  let(:team_id) { team.first.id }

  let(:fixture_id) { fixtures.first.id }

  let(:fixture_params) do
    {
      fixtures: [
          {
            home_team_id: team.last.id,
            away_team_id: team.first.id,
            season_id: season.id,
            match_day: "2018-09-09"
          },
          {
            home_team_id: team.second.id,
            away_team_id: team.first.id,
            season_id: season.id,
            match_day: "2018-09-10"
          }
      ]
    }
  end

  let(:invalid_fixture_params) do
    {
      fixtures: [
          {
            home_team_id: 0,
            away_team_id: team.first.id,
            season_id: season.id,
            match_day: "2018-09-09"
          },
          {
            home_team_id: team.second.id,
            away_team_id: team.first.id,
            season_id: season.id,
            match_day: "2018-09-10"
          }
      ]
    }
  end

  describe "POST /league/:league_id/fixtures" do
    context "when the request is valid" do
      before do
        post api_v1_league_fixtures_path(league_id: league_id), 
            headers: authenticated_header(user),
            params: fixture_params 
      end

      it "returns a created message" do
        expect(json["message"]).to eq("Created")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before do
        post api_v1_league_fixtures_path(league_id: league_id), 
            headers: authenticated_header(user),
            params: invalid_fixture_params 
      end

      it "returns a invalid fixture message" do
        expect(json["errors"]).to eq("Invalid fixture")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "GET /league/:league_id/fixtures" do
    context "when the request is valid" do
      before do
        get api_v1_league_fixture_path(league_id: league_id, id: fixture_id)
      end

      it "returns a list with 10 hashes" do
        expect(json["match"].size).to eq 8
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_id) { 0 }
      before do
        get api_v1_league_fixture_path(league_id: league_id, id: fixture_id)
      end

      it "returns an error message" do
        expect(json["error"]).to eq("The fixture is not available.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /league/:league_id/fixtures/:fixture_id" do
    context "when the request is valid" do
      before do
        delete api_v1_league_fixture_path(league_id: league_id,
                                  id: fixture_id),
              headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Fixture was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do 
      let(:fixture_id) { 0 }

      before do
        delete api_v1_league_fixture_path(league_id: league_id,
                                          id: fixture_id),
              headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The fixture does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /league/:league_id/fixtures/:fixture_id" do
    context "when the request is valid" do
      before do
        put api_v1_league_fixture_path(league_id: league_id, 
                                    id: fixture_id),
            headers: authenticated_header(user)
      end

      it "returns a hash with 8 keys" do
        expect(json['match'].size).to eq 8
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:fixture_id) { 0 }

      before do
        put api_v1_league_fixture_path(league_id: league_id,
                                    id: fixture_id),
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The fixture does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
