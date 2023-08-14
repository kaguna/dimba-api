# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeRequest do
  include AuthenticationSpecHelper

  let!(:role) { create(:role, name: 'Admin') }
  let(:user) { create(:user, role_id: role.id) }
  let(:header) { authenticated_header(payload) }
  let(:valid_request) { described_class.new(header) }
  let(:invalid_request) { described_class.new({}) }

  describe '#call' do
    context 'with valid request' do
      it 'returns the user' do
        result = valid_request.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'with invalid request' do
      context 'with no token' do
        it 'raises missing token error' do
          expect { invalid_request.call }.to raise_error(JWT::DecodeError, /Nil JSON web token/)
        end
      end

      context 'with invalid token' do
        let(:invalid_token_header) { { Authorization: "Bearer #{generate_token(payload: 'invalid_token')}" } }
        subject(:invalid_token_request) { described_class.new(invalid_token_header) }

        it 'raises invalid token error' do
          expect { invalid_token_request.call }.to raise_error(RuntimeError, /Invalid token!/)
        end
      end

      context 'with expired token' do
        subject(:expired_token_request) { described_class.new(expired_token_header) }

        let(:expired_token_header) { { Authorization: "Bearer #{generate_expired_token(user.id)}" } }

        it 'raises expired token error' do
          expect { expired_token_request.call }.to raise_error(JWT::DecodeError, /Signature has expired/)
        end
      end
    end
  end
end
