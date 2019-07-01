require "rails_helper"

RSpec.describe LeaguesSponsor, type: :model do
  describe "Associations" do
    it { should belong_to(:league) }
    it { should belong_to(:sponsor) }
  end
end
