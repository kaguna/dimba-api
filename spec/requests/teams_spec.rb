require 'rails_helper'
require './spec/support/request_helper'

RSpec.describe Team, type: :request do
  include RequestSpecHelper
  let(:team_params) {
   {
        name: 'Kabonge',
        description: 'where pride meets passion',
        location: 'Kirinyaga',
        nickname: '11 Bullets'
   }
   }

  let!(:teams) { create_list(:team, 10) }
  let(:team_id) { teams.first.id }

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

    context 'when the request is invalid' do
      let(:team_params) {
        {
            name: '',
            description: 'where pride meets passion',
            location: 'Kirinyaga',
            nickname: '11 Bullets'
        }
      }

      before { post '/teams/create', params: team_params }

      it 'does not create a new team with empty team name' do
        expect(json['name']).to eq(["can't be blank"])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /teams' do

    context 'when the request is valid' do
      before { get '/teams' }

      it 'shows atleast one team with a name' do
        expect(json.size).to eq 10
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /teams/show/:id' do

    context 'when the request is valid' do
      before { get "/teams/show/#{team_id}" }

      it 'returns a hash with 7 keys' do
        expect(json.size).to eq 7
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:team_id) { 100 }
      before { get "/teams/show/#{team_id}" }

      it 'returns an error message and status code 400' do
        expect(response).to have_http_status(400)
        expect(json['errors']).to eq("The team does not exist")
      end
    end
  end

  describe 'PUT /teams/edit/:id' do

    context 'when the request is valid' do
      before { put "/teams/edit/#{team_id}" }

      it 'returns a hash with 7 keys' do
        expect(json.size).to eq 7
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:team_id) { 100 }
      before { put "/teams/edit/#{team_id}" }

      it 'returns an error message' do
        expect(json['errors']).to eq("The team does not exist")
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
