# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser do
  subject(:user_invalid_credentials) { described_class.new('invalid_email', 'invalid_password') }
  let!(:role) { create(:role, name: 'Admin') }
  let!(:user) { create(:user, role_id: role.id) }
  let(:user_valid_credentials) { described_class.new(user.email, user.password) }

  describe '#call' do
    context 'with valid credentials' do
      it 'returns an auth token' do
        auth_token = user_valid_credentials.call
        expect(auth_token).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'raises an authentication error' do
        expect { user_invalid_credentials.call }.to raise_error(RuntimeError, 'Invalid credentials!')
      end
    end
  end
end
