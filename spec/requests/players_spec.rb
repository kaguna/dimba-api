require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Player, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:team) { create(:team) }

  let!(:player) do
    create_list(
      :player, 10,
      team_id: team.id
    )
  end

  let(:team_id) { team.id }
  let(:player_id) { player.first.id }

  let(:player_params) { attributes_for(:player) }

  describe "POST players/create" do
    context "when the request is valid" do
      before do
        post "/team/#{team_id}/player",
             headers: authenticated_header(user),
             params: player_params
      end

      it "creates a new player with 11 attributes" do
        expect(json.size).to eq 11
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:player_params) do
        {
          first_name: "",
          second_name: "Kariuki",
          last_name: "Kaguna",
          nick_name: "jimnah",
          id_number: "31262778",
          dob: "1997-09-19",
          phone_number: "0715739940",
          team_id: player_id
        }
      end

      before do
        post "/team/#{team_id}/player",
             headers: authenticated_header(user),
             params: player_params
      end

      it "does not create a new player with empty player first name" do
        expect(json["first_name"]).to eq(["can't be blank"])
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET /team/:team_id/players" do
    context "when the request is valid" do
      before { get "/team/#{team_id}/players" }

      it "returns a list of 10 player hashes" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:team_id) { 1 }
      before { get "/team/#{team_id}/players" }

      it "returns an error message" do
        expect(json["errors"]).to eq("The team does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /team/:team_id/player/:player_id" do
    context "when the request is valid" do
      before { delete "/team/#{team_id}/player/#{player_id}" }

      before do
        delete "/team/#{team_id}/player/#{player_id}",
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Player was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:player_id) { 100 }

      before do
        delete "/team/#{team_id}/player/#{player_id}",
               headers: authenticated_header(user)
      end

      it "returns an error message and status code 400" do
        expect(json["errors"]).to eq("The player does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /team/:team_id/player/:player_id" do
    context "when the request is valid" do
      before do
        put "/team/#{team_id}/player/#{player_id}",
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
      let(:player_id) { 0 }

      before do
        put "/team/#{team_id}/player/#{player_id}",
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The player does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
