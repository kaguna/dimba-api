require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe Fixture, type: :request do

  include RequestSpecHelper
  let!(:team) { create_list(:team, 10) }
  let!(:fixtures) do
    create_list(
      :fixture, 10,
      home_team: team.last.id,
      away_team: team.first.id
    )
  end

  let(:team_id) { team.first.id }
  let(:fixture_id) { fixtures.first.id }
  let(:fixture_params) {
    {
        "home_team": team.last.id,
        "away_team": team.first.id,
        "season": "2017/2018",
        "match_day": "2018-09-09",
    }
  }

  describe "POST fixture/create" do
    context "when the request is valid" do
      before { post "/fixtures", params: fixture_params }

      it "creates a new fixture" do
        expect(json.size).to eq 7
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /fixtures" do
    context "when the request is valid" do
      before { get "/fixtures" }

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_id) { 1 }
      before { get "/fixtures/#{fixture_id}" }

      it "returns an error message" do
        expect(json["error"]).to eq("The fixture is not available.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /fixture/:fixture_id" do
    context "when the request is valid" do
      before { delete "/fixtures/#{fixture_id}" }

      it "returns a success message" do
        expect(json["message"]).to eq("Fixture was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:fixture_id) { 0 }
      before { delete "/fixtures/#{fixture_id}" }

      it "returns an error message" do
        expect(json["errors"]).to eq("The fixture does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /fixtures/:fixture_id" do
    context "when the request is valid" do
      before { put "/fixtures/#{fixture_id}" }

      it "returns a hash with 7 keys" do
        expect(json.size).to eq 7
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:fixture_id) { 0 }
      before { put "/fixtures/#{fixture_id}" }

      it "returns an error message" do
        expect(json["errors"]).to eq("The fixture does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
