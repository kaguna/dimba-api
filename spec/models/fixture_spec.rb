require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Fixture, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:away_team) }
    it { should validate_presence_of(:home_team) }
  end
end
