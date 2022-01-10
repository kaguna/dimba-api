require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Result, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:referee_role) { create(:role, name: "Referee") }

  let!(:user) { create(:user, role_id: referee_role.id) }

  let!(:admin_role) { create(:role, name: "Admin") }

  let!(:admin) { create(:user, role_id: admin_role.id) }

  let!(:teams) { create_list(:team, 2) }

  let!(:league) { create(:league) }

  let!(:season) { create(:season) }

  let!(:fixture) do
    create(:fixture,
           home_team_id: teams.last.id,
           away_team_id: teams.first.id,
           season_id: season.id,
           league_id: league.id)
  end

  let(:results) { create(:result, fixture_id: fixture.id) }

  let(:results_params) { attributes_for(:result) }

  xdescribe "POST /fixture/:fixture_id/results" do
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

  xdescribe "GET /fixture/:fixture_id/results" do
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

  xdescribe "PUT /fixture/:fixture_id/results/:result_id" do
    context "when the request is valid" do
      before do
        put api_v1_edit_result_path(fixture_id: fixture.id,
                                    result_id: results.id),
            headers: authenticated_header(user)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:result_id) { 0 }

      before do
        put api_v1_edit_result_path(fixture_id: fixture.id,
                                    result_id: result_id),
            headers: authenticated_header(user)
      end

      it "returns status code 400" do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe "DELETE /fixture/:fixture_id/results/:result_id" do
    context "when the request is valid" do
      before do
        delete api_v1_delete_result_path(fixture_id: fixture.id,
                                         result_id: results.id),
               headers: authenticated_header(admin)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      let(:result_id) { 0 }

      before do
        delete api_v1_delete_result_path(fixture_id: fixture.id,
                                         result_id: result_id),
               headers: authenticated_header(admin)
      end

      it "returns status code 400" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
