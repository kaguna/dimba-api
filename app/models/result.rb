class Result < ApplicationRecord
  has_one :fixture
  validates :fixture_id, presence: true, uniqueness: true
end
