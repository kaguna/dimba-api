require "rails_helper"

RSpec.describe LeaguesTeam, type: :model do
  describe "Associations" do
    it { should belong_to(:league) }
    it { should belong_to(:team) }

  end
end
