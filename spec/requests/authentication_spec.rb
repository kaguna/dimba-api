# frozen_string_literal: true

require 'rails_helper'
require './spec/support/request_helper'

RSpec.describe 'Authentication', type: :request do
  include RequestSpecHelper
  include AuthenticationSpecHelper

  describe 'POST /user/login' do
    let!(:role) { create(:role, name: "Admin") }
    let!(:user) { create(:user, role_id: role.id) }

    let(:valid_auth_params) do
      {
        email: user.email,
        password: user.password
      }
    end

    let(:invalid_auth_params) do
      {
        email: 'invalid email',
        password: 'invalid password'
      }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/user/login', params: valid_auth_params
      end

      it 'returns auth token' do
        expect(json[:jwt]).not_to be_nil
      end
    end

    context 'when the request is invalid' do
      before do
        post '/api/v1/user/login', params: invalid_auth_params
      end

      it 'raises a failure message' do
        expect(json[:error]).to match('Invalid credentials!')
      end
    end
  end
end
