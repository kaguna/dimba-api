require "rails_helper"
require "./spec/support/request_helper"

RSpec.describe Player, type: :model do
  describe "Validations" do
    xit { should validate_presence_of(:id_number) }
    xit { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:second_name) }
  end
end
