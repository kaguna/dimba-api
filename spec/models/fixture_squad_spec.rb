require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe FixtureSquad, type: :model do
  describe "Validations" do

    context "when inputs must be present" do
      it { should validate_presence_of(:players_id) }
      it { should validate_presence_of(:teams_id) }
      it { should validate_presence_of(:fixtures_id) }
    end
  end
end