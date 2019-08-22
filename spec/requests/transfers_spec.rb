require 'rails_helper'

RSpec.describe Transfer, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: 'Admin') }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:teams) { create_list(:team, 10) }

  let!(:player) { create(:player, team_id: teams.first.id) }

  let!(:transfer) do
    create(:transfer,
           from_team_id: teams.first.id,
           to_team_id: teams.last.id,
           player_id: player.id)
  end

  let(:player_id) { player.id }
  let(:transfer_id) { transfer.id }

  let!(:transfer_params) do
    {
      from_team_id: teams.first.id,
      to_team_id: teams.last.id,
      player_id: player.id,
      transfer_comment: 'Good',
      transfer_budget: '2000',
      contract_time: '2'
    }
  end

  describe 'POST /transfers' do
    context 'when the request is valid' do
      before do
        post api_v1_transfer_index_path,
             headers: authenticated_header(user),
             params: transfer_params
      end

      it 'creates a new transfer' do
        expect(json.size).to eq 9
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'GET /transfers' do
    context 'when the request is valid' do
      before do
        get api_v1_transfer_index_path
      end

      it 'returns a list with 1 hash of on player transfer' do
        expect(json.size).to eq 1
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request for a specific player' do
      before do
        get api_v1_transfer_path(id: transfer_id)
      end

      it 'returns a hash with 9 keys' do
        expect(json.size).to eq 9
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when player has no transfer history' do
      let!(:transfer_id) { 100 }
      before do
        get api_v1_transfer_path(id: transfer_id)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /transfers/:transfer_id' do
    context 'when the request is valid' do
      before do
        delete api_v1_transfer_path(id: transfer_id),
               headers: authenticated_header(user)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the request is invalid' do
      let(:transfer_id) { 0 }

      before do
        delete api_v1_transfer_path(id: transfer_id),
               headers: authenticated_header(user)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /transfers/:transfer_id' do
    context 'when the request is valid' do
      before do
        put api_v1_transfer_path(id: transfer_id),
            headers: authenticated_header(user)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:transfer_id) { 100 }

      before do
        put  api_v1_transfer_path(id: transfer_id),
             headers: authenticated_header(user)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
