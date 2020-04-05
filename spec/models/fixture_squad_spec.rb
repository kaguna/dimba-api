require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe FixtureSquad, type: :model do
  describe "Validations" do
    context "when inputs must be present" do
      it { should validate_presence_of(:player_id) }
      it { should validate_presence_of(:team_id) }
      it { should validate_presence_of(:fixture_id) }
    end
  end
end