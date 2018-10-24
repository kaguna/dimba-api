require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    context "when inputs must be present" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
    end

    context "when inputs must be unique" do
      it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context "when password length is satisfied" do
      it { should validate_length_of(:password).is_at_least(8) }
      it { should have_secure_password }
    end
  end
end
