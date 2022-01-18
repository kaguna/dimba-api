require 'rails_helper'
require './spec/support/request_helper'

RSpec.describe Event, type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: 'Admin') }

  let!(:user) { create(:user, role_id: role.id) }

  let!(:event) { create_list(:event, 10) }

  let(:event_id) { event.first.id }

  let(:event_params) { attributes_for(:event) }

  describe 'POST /events' do
    context 'when the request is valid' do
      before do
        post api_v1_events_path,
            headers: authenticated_header(payload),
            params: event_params
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'GET /events' do
    context 'when the request is valid' do
      before do
        get api_v1_events_path
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /events/:event_id' do
    context 'when the request is valid' do
      before do
        get api_v1_event_path(id: event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let!(:event_id) { 1000 }

      before do
        get api_v1_event_path(id: event_id)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /events/:event_id' do
    context 'when the request is valid' do
      before do
        delete api_v1_event_path(id: event_id),
              headers: authenticated_header(payload)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the request is invalid' do
      let(:event_id) { 1000 }

      before do
        delete api_v1_event_path(id: event_id),
              headers: authenticated_header(payload)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /events/:event_id' do
    context 'when the request is valid' do
      before do
        put api_v1_event_path(id: event_id),
            headers: authenticated_header(payload)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:event_id) { 1000 }

      before do
        put api_v1_event_path(id: event_id),
            headers: authenticated_header(payload)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
