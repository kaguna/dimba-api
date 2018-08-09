require 'rails_helper'
require './spec/support/request_helper'

RSpec.describe Event, type: :model do
  it "is valid with valid attributes" do
    expect(Event.new).to be_valid
  end
end
