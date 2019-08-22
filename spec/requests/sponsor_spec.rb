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
        post api_v1_sponsor_index_path,
             headers: authenticated_header(user),
             params: sponsor_params
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
        post api_v1_sponsor_index_path,
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
        get api_v1_sponsor_index_path
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /sponsors/:sponsor_id" do
    context "when the request is valid" do
      before do
        get api_v1_sponsor_path(id: sponsor_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:sponsor_id) { 1000 }
      before do
        get api_v1_sponsor_path(id: sponsor_id)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE /sponsors/:sponsor_id" do
    context "when the request is valid" do

      before do
        delete api_v1_sponsor_path(id: sponsor_id),
               headers: authenticated_header(user)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when the request is invalid" do
      let(:sponsor_id) { 100 }

      before do
        delete api_v1_sponsor_path(id: sponsor_id),
               headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "PUT /sponsors/:sponsor_id" do
    context "when the request is valid" do
      before do
        put api_v1_sponsor_path(id: sponsor_id),
            headers: authenticated_header(user)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:sponsor_id) { 1000 }

      before do
        put api_v1_sponsor_path(id: sponsor_id),
            headers: authenticated_header(user)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
