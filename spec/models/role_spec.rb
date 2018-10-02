require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Role, type: :model do
  describe "Validations" do

    context "when inputs must be present" do
      it { should validate_presence_of(:name) }
    end
  end
end
