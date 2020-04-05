require "rails_helper"

RSpec.describe League, type: :model do
  describe "Associations" do
    it { should have_many(:fixtures) }
    it { should have_many(:teams).through(:leagues_teams) }
    it { should have_many(:leagues_sponsors) }

  end
end
