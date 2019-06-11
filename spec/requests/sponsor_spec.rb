require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Sponsor, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:sponsor) { create_list(:sponsor, 10) }

  let(:sponsor_id) { sponsor.first.id }

  let(:sponsor_params) { attributes_for(:sponsor) }

  describe "POST /sponsors" do
    context "when the request is valid" do
      before do
        post api_v1_add_sponsor_path,
             headers: authenticated_header(user),
             params: sponsor_params
      end

      it "creates a new sponsor with 6 attributes" do
        expect(json.size).to eq 6
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:sponsor_params) do
        {
          name: "",
          description: "More money, less stress",
          contacts: "https//www.example.com",
        }
      end

      before do
        post api_v1_add_sponsor_path,
             headers: authenticated_header(user),
             params: sponsor_params
      end

      it "does not create a new sponsor with empty name" do
        expect(json["name"]).to eq(["can't be blank"])
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET /sponsors" do
    context "when the request is valid" do
      before do
        get api_v1_sponsors_path
      end

      it "shows an array of 10 sponsors" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /sponsors/:sponsor_id" do
    context "when the request is valid" do
      before do
        get api_v1_sponsor_path(sponsor_id: sponsor_id)
      end

      it "returns one sponsor's details" do
        expect(json.size).to eq 6
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:sponsor_id) { 1000 }
      before do
        get api_v1_sponsor_path(sponsor_id: sponsor_id)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The sponsor does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /sponsors/:sponsor_id" do
    context "when the request is valid" do

      before do
        delete api_v1_delete_sponsor_path(sponsor_id: sponsor_id),
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Sponsor was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:sponsor_id) { 100 }

      before do
        delete api_v1_delete_sponsor_path(sponsor_id: sponsor_id),
               headers: authenticated_header(user)
      end

      it "returns an error message and status code 400" do
        expect(json["errors"]).to eq("The sponsor does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /sponsors/:sponsor_id" do
    context "when the request is valid" do
      before do
        put api_v1_edit_sponsor_path(sponsor_id: sponsor_id),
            headers: authenticated_header(user)
      end

      it "returns a hash with 6 keys" do
        expect(json.size).to eq 6
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:sponsor_id) { 100 }

      before do
        put api_v1_edit_sponsor_path(sponsor_id: sponsor_id),
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The sponsor does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
