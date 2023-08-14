require "rails_helper"
require "./spec/support/request_helper"
require "./spec/support/authentication_helper"

RSpec.describe Commentary, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:ref_role) { create(:role, name: "Referee") }

  let!(:user_ref) do
    create_list(:user, 3,
                role_id: ref_role.id)
  end

  let(:league) { create(:league) }

  let(:team) { create_list(:team, 10) }

  let!(:event) { create(:event) }

  let(:season) { create(:season) }

  let!(:fixture) do
    create(
      :fixture,
      home_team_id: team.last.id,
      away_team_id: team.first.id,
      season_id: season.id,
      league_id: league.id
    )
  end

  let!(:player) do
    create_list(
      :player, 10,
      team_id: team.first.id
    )
  end

  let!(:commentaries) do
    create_list( 
        :commentary, 10,
        event_id: event.id,
        fixture_id: fixture.id,
        team_id: team.last.id,
        player_id: player.first.id
    )
  end

  let(:team_id) { team.first.id }
  let(:player_id) { player.first.id }
  let(:fixture_id) { fixture.id }
  let(:commentary_id) { commentaries.first.id }

  let(:commentary_params) do 
    { 
      event_id: event.id,
      fixture_id: fixture.id,
      team_id: team.last.id,
      commentary_time: 71,
      player_id: player.first.id
    }
  end

  xdescribe "POST commentary/create" do
    context "when the request is valid" do
      before do
        post api_v1_fixture_commentaries_path(fixture_id: fixture_id),
            headers: authenticated_header(user),
            params: commentary_params
      end

      it "creates a new commentary with 6 attributes" do
        expect(json['commentary'].size).to eq 6
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is not made by referee or admin" do
      let(:role) { create(:role, name: "User") }
      let(:user) { create(:user, role_id: role.id) }

      before do
        post  api_v1_fixture_commentaries_path(fixture_id: fixture_id),
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

  xdescribe "GET /fixture/:fixture_id/commentaries" do
    context "when the request is valid" do
      before do
        get  api_v1_fixture_commentaries_path(fixture_id: fixture_id)
      end

      it "returns a list with 6 hashes" do
        expect(json['commentary'].size).to eq 6
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:commentary_id) { 1000 }

      before do
        get  api_v1_fixture_commentary_path(id: commentary_id,
                                            fixture_id: fixture_id)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe "DELETE /commentaries/:commentary_id" do
    context "when the request is made by normal user" do
      let(:role) { create(:role, name: "User") }
      let(:user) { create(:user, role_id: role.id) }

      before do
        delete api_v1_fixture_commentary_path(fixture_id: fixture_id,
                                              id: commentary_id),
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
        delete api_v1_fixture_commentary_path(fixture_id: fixture_id,
                                              id: commentary_id),
              headers: authenticated_header(user)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when the request is invalid" do

      let(:commentary_id) { 100 }

      before do
        delete api_v1_fixture_commentary_path(fixture_id: fixture_id,
                                              id: commentary_id),
              headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe "PUT /commentaries/:commentary_id" do
    context "when the request is valid" do
      before do
        put api_v1_fixture_commentary_path(fixture_id: fixture_id,
                                          id: commentary_id),
            headers: authenticated_header(user)
      end

      it "returns a hash with 6 keys" do
        expect(json['commentary'].size).to eq 6
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:commentary_id) { 100 } 

      before do
        put api_v1_fixture_commentary_path(fixture_id: fixture_id,
                                          id: commentary_id),
            headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
