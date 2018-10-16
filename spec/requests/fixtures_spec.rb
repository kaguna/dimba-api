require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe Fixture, type: :request do

  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:ref_role) { create(:role, name: "Referee") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:user_ref) {
    create_list(:user, 3,
                role_id: ref_role.id
    )
  }

  let!(:team) { create_list(:team, 10) }

  let!(:league) { create(:league) }

  let!(:fixtures) do
    create_list(
      :fixture, 10,
      home_team: team.last.id,
      away_team: team.first.id,
      league_id: league.id,
      center_referee: user_ref.first.id,
      right_side_referee: user_ref.last.id,
      left_side_referee: user_ref.second.id
    )
  end

  let(:league_id) { league.id }
  let(:team_id) { team.first.id }
  let(:fixture_id) { fixtures.first.id }
  let(:fixture_params) {
    {
        "home_team": team.last.id,
        "away_team": team.first.id,
        "league_id": league.id,
        "season": "2017/2018",
        "match_day": "2018-09-09",
    }
  }

  describe "POST /league/:league_id/fixtures" do
    context "when the request is valid" do

      before do
        post "/league/#{league_id}/fixtures",
             headers: authenticated_header(user),
             params: fixture_params
      end

      it "creates a new fixture" do
        expect(json.size).to eq 11
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /league/:league_id/fixtures" do
    context "when the request is valid" do
      before do
        get "/league/#{league_id}/fixtures"
      end

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_id) { 0 }
      before do
        get "/league/#{league_id}/fixtures/#{fixture_id}"
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
        delete "/league/#{league_id}/fixtures/#{fixture_id}",
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
        delete "/league/#{league_id}/fixtures/#{fixture_id}",
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
        put "/league/#{league_id}/fixtures/#{fixture_id}",
            headers: authenticated_header(user)
      end

      it "returns a hash with 11 keys" do
        expect(json.size).to eq 11
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do

      let(:fixture_id) { 0 }

      before do
        put "/league/#{league_id}/fixtures/#{fixture_id}",
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
