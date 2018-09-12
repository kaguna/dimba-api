require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Event, type: :request do
  include RequestSpecHelper

  let(:team) { create_list(:team, 10) }

  let!(:fixture) do
    create(
      :fixture,
      home_team: team.last.id,
      away_team: team.first.id
    )
  end

  let!(:player) do
    create_list(
      :player, 10,
      team_id: team.first.id
    )
  end

  let!(:event) do
    create_list(
      :event, 10,
      fixtures_id: fixture.id,
      teams_id: team.last.id,
      players_id: player.first.id
    )
  end

  let(:team_id) { team.first.id }
  let(:player_id) { player.first.id }
  let(:fixture_id) { fixture.id }
  let(:event_id) { event.first.id }

  let(:event_params) { attributes_for(:event) }

  describe "POST event/create" do
    context "when the request is valid" do
      before do
        post "/fixture/#{fixture_id}/events",
             params: event_params
      end

      it "creates a new event" do
        expect(json.size).to eq 9
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /fixture/:fixture_id/events" do
    context "when the request is valid" do
      before { get "/fixture/#{fixture_id}/events" }

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_id) { 1 }

      before { get "/fixture/#{fixture_id}/events" }

      it "returns an error message" do
        expect(json["error"]).to eq("No events for this game.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /events/:event_id" do
    context "when the request is valid" do
      before { delete "/fixture/#{fixture_id}/events/#{event_id}" }

      it "returns a success message" do
        expect(json["message"]).to eq("Event was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:event_id) { 0 }
      before { delete "/fixture/#{fixture_id}/events/#{event_id}" }

      it "returns an error message" do
        expect(json["errors"]).to eq("The events does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /events/:event_id" do
    context "when the request is valid" do
      before { put "/fixture/#{fixture_id}/events/#{event_id}" }

      it "returns a hash with 11 keys" do
        expect(json.size).to eq 9
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:event_id) { 0 }
      before { put "/fixture/#{fixture_id}/events/#{event_id}" }

      it "returns an error message" do
        expect(json["errors"]).to eq("The events does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
