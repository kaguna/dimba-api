require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Team, type: :request do
  include RequestSpecHelper

  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:teams) { create_list(:team, 10) }

  let(:team_id) { teams.first.id }

  let(:team_params) { attributes_for(:team) }

  describe "POST teams/create" do
    context "when the request is valid" do
      before { post "/teams", params: team_params }

      before do
        post "/teams", headers: authenticated_header(user), params: team_params
      end

      it "creates a new team with 7 attributes" do
        expect(json.size).to eq 7
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:team_params) {
        {
            name: "",
            description: "where pride meets passion",
            location: "Kirinyaga",
            nickname: "11 Bullets"
        }
      }

      before do
        post "/teams", headers: authenticated_header(user),
             params: team_params
      end

      it "does not create a new team with empty team name" do
        expect(json["name"]).to eq(["can't be blank"])
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET /teams" do
    context "when the request is valid" do
      before { get "/teams" }

      it "shows an array of 10 teams" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /team/:team_id" do
    context "when the request is valid" do

      before do
        delete "/teams/#{team_id}",
               headers: authenticated_header(user)
      end

      it "returns a success message and status code 200" do
        expect(json["message"]).to eq("Team was successfully deleted")
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:team_id) { 0 }

      before do
        delete "/teams/#{team_id}",
               headers: authenticated_header(user)
      end

      it "returns an error message and status code 400" do
        expect(json["errors"]).to eq("The team does not exist")
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "GET /team/:id" do
    context "when the request is valid" do
      before { get "/teams/#{team_id}" }

      it "returns a hash with 7 keys" do
        expect(json.size).to eq 7
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:team_id) { 100 }

      before { get "/teams/#{team_id}" }

      it "returns an error message and status code 400" do
        expect(response).to have_http_status(400)
        expect(json["errors"]).to eq("The team does not exist")
      end
    end
  end

  describe "PUT /teams/edit/:id" do
    context "when the request is valid" do
      before { put "/teams/#{team_id}" }

      before do
        put "/teams/#{team_id}",
            headers: authenticated_header(user)
      end

      it "returns a hash with 7 keys" do
        expect(json.size).to eq 7
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:team_id) { 100 }

      before do
        put "/teams/#{team_id}",
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The team does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
