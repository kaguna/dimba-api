require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Sponsor, type: :model do
  describe "Validations" do
    context "when inputs must be present" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:contacts) }
    end
  end
end
