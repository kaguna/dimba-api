require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Fixture, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:away_team_id) }
    it { should validate_presence_of(:home_team_id) }
  end
end
