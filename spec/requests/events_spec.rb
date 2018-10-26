require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe Event, type: :request do

  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: "Admin") }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:event) { create_list(:event, 10) }

  let(:event_id) { event.first.id }

  let(:event_params) { attributes_for(:event) }

  describe "POST /events" do
    context "when the request is valid" do
      before do
        post "/events",
             headers: authenticated_header(user),
             params: event_params
      end

      it "creates a new event with 5 attributes" do
        expect(json.size).to eq 5
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:event_params) do
        {
          name: "",
          description: "An exemplary goal"
        }
      end

      before do
        post "/events",
             headers: authenticated_header(user),
             params: event_params
      end

      it "does not create a new event with empty name" do
        expect(json["name"]).to eq(["can't be blank"])
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET /events" do
    context "when the request is valid" do
      before { get "/events" }

      it "shows an array of 10 events" do
        expect(json.size).to eq 10
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /events/:event_id" do
    context "when the request is valid" do
      before { get "/events/#{event_id}" }

      it "returns one event's details" do
        expect(json.size).to eq 5
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:event_id) { 1000 }

      before { get "/events/#{event_id}" }

      it "returns an error message" do
        expect(json["error"]).to eq("The event is not found!")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /events/:event_id" do
    context "when the request is valid" do
      before do
        delete "/events/#{event_id}",
               headers: authenticated_header(user)
      end

      it "returns a success message" do
        expect(json["message"]).to eq("Event was successfully deleted")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:event_id) { 1000 }

      before do
        delete "/events/#{event_id}",
               headers: authenticated_header(user)
      end

      it "returns an error message and status code 400" do
        expect(json["errors"]).to eq("The event does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PUT /events/:event_id" do
    context "when the request is valid" do
      before do
        put "/events/#{event_id}",
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
      let(:event_id) { 1000 }

      before do
        put "/events/#{event_id}",
            headers: authenticated_header(user)
      end

      it "returns an error message" do
        expect(json["errors"]).to eq("The event does not exist")
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end
end
