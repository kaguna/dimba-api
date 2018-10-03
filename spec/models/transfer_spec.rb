require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Transfer, type: :model do
  describe "Validations" do

    context "check presence of attributes" do
      it { should validate_presence_of(:player_id) }
      it { should validate_presence_of(:from_team_id) }
      it { should validate_presence_of(:to_team_id) }
    end
  end
end
