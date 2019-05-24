require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Result, type: :model do
  describe "Validations" do
    context "when inputs must be present" do
      it { should validate_presence_of(:fixture_id) }
    end
  end
end
