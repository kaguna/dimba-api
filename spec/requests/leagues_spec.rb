require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe League, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:league) { create(:league) }

  let(:league_id) { league.id }

  let(:league_params) { attributes_for(:league) }

  describe "POST /leagues" do
    context "when the request is valid" do
      before do
        post api_v1_add_league_path,
             headers: authenticated_header(user),
             params: league_params
      end

      it "creates a new league" do
        expect(json.size).to eq 5
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /leagues" do
    context "when the request is valid" do
      before do
        get api_v1_leagues_path
      end

      it "returns a list with 1 hash of a league" do
        expect(json.size).to eq 1
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:league_id) { 1 }
      before do
        get api_v1_league_path(league_id: league_id)
      end

      it "returns an error message" do
        expect(json["error"]).to eq("The league does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE leagues/:league_id" do
    context "when the request is valid" do
      before do
        delete api_v1_delete_league_path(league_id: league_id),
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("League was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:league_id) { 0 }

      before do
        delete api_v1_delete_league_path(league_id: league_id),
               headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The league does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /leagues/:league_id" do
    context "when the request is valid" do
      before do
        put api_v1_edit_league_path(league_id: league_id),
            headers: authenticated_header(user)
      end

      it "returns a hash with 5 keys" do
        expect(json.size).to eq 5
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:league_id) { 0 }

      before do
        put api_v1_edit_league_path(league_id: league_id),
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The league does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
