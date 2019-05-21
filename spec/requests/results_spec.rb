require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Result, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:referee_role) { create(:role, name: "Referee") }

  let!(:user) { create(:user, role_id: referee_role.id) }

  let!(:teams) { create_list(:team, 2) }

  let!(:league) { create(:league) }

  let!(:fixture) do
    create(:fixture,
           home_team: teams.last.id,
           away_team: teams.first.id,
           league_id: league.id)
  end

  let!(:results) { create(:result, fixture_id: fixture.id) }

  let(:results_params) { attributes_for(:result) }

  describe "POST /fixture/:fixture_id/results" do
    context "when the request is valid" do
      before do
        post api_v1_add_results_path(fixture_id: fixture.id),
             headers: authenticated_header(user),
             params: results_params
      end
      it "creates new results and returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /fixture/:fixture_id/results" do
    context "when the request is valid" do
      before do
        get api_v1_results_path(fixture_id: fixture.id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let!(:result_id) { 0 }
      before do
        get api_v1_result_path(fixture_id: fixture.id,
                               result_id: result_id)
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end


end

