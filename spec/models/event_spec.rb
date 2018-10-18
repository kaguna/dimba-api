require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Event, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end
