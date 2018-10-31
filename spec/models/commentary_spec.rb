require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Commentary, type: :model do
  it "is valid with valid attributes" do
    expect(Commentary.new).to be_valid
  end
end
