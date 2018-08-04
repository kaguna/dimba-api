require 'rails_helper'

RSpec.describe Team, type: :request do
  let(:team_params) {
    {
        name: 'Kabonge',
        description: 'where pride meets passion',
        location: 'Kirinyaga',
        nickname: '11 Bullets'
    }
  }
  let(:json) { JSON(response.body) }

  describe 'POST teams/create' do

    context 'when the request is valid' do
      before { post '/teams/create', params: team_params }

      it 'creates a new team' do
        expect(json['name']).to eq('Kabonge')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end

