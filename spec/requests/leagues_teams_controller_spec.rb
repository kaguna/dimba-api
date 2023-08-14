require 'rails_helper'
require './spec/support/request_helper'

RSpec.describe LeaguesTeam, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let(:role) { create(:role, name: 'Admin') }

  let(:user) { create(:user, role_id: role.id) }

  let!(:league) { create(:league) }

  let(:teams) { create_list(:team, 5) }

  let(:league_id) { league.id }

  let!(:league_teams) { create_list(:league_teams, 5, league_id: league_id) }

  let(:league_team_id) { league_teams.first.id } 

  let(:league_teams_params) do
    {
      leagues_team: {
        attributes: [
          {
            team_id: teams.first.id
          },
          {
            team_id: teams.second.id
          }
        ]
      }
    }
  end

  let(:num_teams) { league_teams_params[:league_teams].size }

  xdescribe 'POST /league/:league_id/league_teams' do
    context 'when the request is valid' do
      before do
        post api_v1_league_leagues_teams_path(league_id: league_id),
            headers: authenticated_header(user),
            params: league_teams_params
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  xdescribe 'GET /league/:league_id/league_teams' do
    context 'when the request is valid' do

      before do
        get api_v1_league_leagues_teams_path(league_id: league_id)
      end

      it 'returns hashes with keys' do
        expect(json[0].keys).to match %w[id name description location nickname]
      end

      it 'returns a list with 5 hashes' do
        expect(json.size).to eq 5
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let!(:league_team_id) { 1 }
      before do
        get api_v1_league_leagues_team_path(league_id: league_id,
                                            id: league_team_id)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe 'DELETE /league/:league_id/league_teams/:league_team_id' do
    context 'when the request is valid' do
      before do
        delete api_v1_league_leagues_team_path(league_id: league_id,
                                              id: league_team_id),
              headers: authenticated_header(user)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the request is invalid' do
      let(:league_team_id) { 0 }

      before do
        delete api_v1_league_leagues_team_path(league_id: league_id,
                                              id: league_team_id),
              headers: authenticated_header(user)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  xdescribe 'PUT /league/:league_id/league_teams/:league_team_id' do
    context 'when the request is valid' do
      before do
        put api_v1_league_leagues_team_path(league_id: league_id,
                                            id: league_team_id),
            headers: authenticated_header(user)
      end

      it 'returns a hash with 5 keys' do
        expect(json.keys).to match %w[id team_id league_id created_at updated_at]
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:league_team_id) { 0 }

      before do
        put api_v1_league_leagues_team_path(league_id: league_id,
                                            id: league_team_id),
            headers: authenticated_header(user)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
