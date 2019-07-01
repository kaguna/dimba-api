require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Commentary, type: :model do
  describe "Associations" do
    it { should belong_to(:fixture) }
  end
end
