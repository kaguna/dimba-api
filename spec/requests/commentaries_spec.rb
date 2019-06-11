require "rails_helper"
require "./spec/support/request_helper"
require "./spec/support/authentication_helper"

RSpec.describe Commentary, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let(:team) { create_list(:team, 10) }

  let(:event) { create(:event) }

  let(:season) { create(:season) }

  let!(:fixture) do
    create(
      :fixture,
      home_team: team.last.id,
      away_team: team.first.id,
      season_id: season.id
    )
  end

  let!(:player) do
    create_list(
      :player, 10,
      team_id: team.first.id
    )
  end

  let!(:commentary) do
    create_list(
        :commentary, 10,
        events_id: event.id,
        fixtures_id: fixture.id,
        teams_id: team.last.id,
        players_id: player.first.id
    )
  end

  let(:team_id) { team.first.id }
  let(:player_id) { player.first.id }
  let(:fixture_id) { fixture.id }
  let(:commentary_id) { commentary.first.id }

  let(:commentary_params) { attributes_for(:commentary) }

  describe "POST commentary/create" do
    context "when the request is valid" do
      before do
        post api_v1_add_commentary_path(fixture_id: fixture_id),
             headers: authenticated_header(user),
             params: commentary_params
      end

      it "creates a new commentary" do
        expect(json.size).to eq 9
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is not made by referee or admin" do
      let(:role) { create(:role, name: "User") }
      let(:user) { create(:user, role_id: role.id) }

      before do
        post  api_v1_add_commentary_path(fixture_id: fixture_id),
              headers: authenticated_header(user),
              params: commentary_params
      end

      it "creates a new event" do
        expect(json["message"]).to eq("Cannot perform the action!")
      end

      it "returns status code 403" do
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "GET /fixture/:fixture_id/commentaries" do
    context "when the request is valid" do
      before do
        get  api_v1_game_commentaries_path(fixture_id: fixture_id)
      end

      it "returns a list with 10 hashes" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:fixture_id) { 1 }

      before do
        get  api_v1_game_commentaries_path(fixture_id: fixture_id)
      end

      it "returns an error message" do
        expect(json["error"]).to eq("No commentary for this game.")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /commentaries/:commentary_id" do
    context "when the request is made by normal user" do
      let(:role) { create(:role, name: "User") }
      let(:user) { create(:user, role_id: role.id) }

      before do
        delete api_v1_delete_commentary_path(fixture_id: fixture_id,
                                             commentary_id: commentary_id),
               headers: authenticated_header(user)
      end

      it "returns a forbidden action message" do
        expect(json["message"]).to eq("Cannot perform the action!")
      end

      it "returns status code 403" do
        expect(response).to have_http_status(403)
      end
    end

    context "when the request is made by an admin" do
      before do
        delete api_v1_delete_commentary_path(fixture_id: fixture_id,
                                             commentary_id: commentary_id),
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Commentary was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do

      let(:commentary_id) { 100 }

      before do
        delete api_v1_delete_commentary_path(fixture_id: fixture_id,
                                             commentary_id: commentary_id),
               headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The commentary does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /commentaries/:commentary_id" do
    context "when the request is valid" do
      before do
        put api_v1_edit_commentary_path(fixture_id: fixture_id,
                                        commentary_id: commentary_id),
            headers: authenticated_header(user)
      end

      it "returns a hash with 11 keys" do
        expect(json.size).to eq 9
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:commentary_id) { 0 }

      before do
        put api_v1_edit_commentary_path(fixture_id: fixture_id,
                                        commentary_id: commentary_id),
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The commentary does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
