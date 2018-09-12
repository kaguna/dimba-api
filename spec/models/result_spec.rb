require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Result, type: :model do
  it "is valid with valid attributes" do
    expect(Result.new).to be_valid
  end
end
