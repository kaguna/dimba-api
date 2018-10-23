require "rails_helper"
require "./spec/support/request_helper"
RSpec.describe User, type: :request do
  include RequestSpecHelper

  let(:role) { create(:role, name: "Admin") }

  let(:user) { create(:user, role_id: role.id) }

  let(:user_params) { attributes_for(:user) }

  describe "POST user/signup" do
    context "when the request is valid" do
      before do
        post "/user/sign_up", params: user_params
      end

      it "creates a new user with 7 attributes" do
        expect(json.size).to eq 7
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:user_params) do
        {
          username: "",
          email: "",
          role_id: 1,
          password: "qwerty123",
        }
      end

      before { post "/user/sign_up", params: user_params }

      it "does not create a new user with empty username or email" do
        expect(json["username"]).to eq(["can't be blank"])
        expect(json["email"]).to eq(["can't be blank"])
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
