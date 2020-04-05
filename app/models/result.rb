class Result < ApplicationRecord
  belongs_to :fixture
  validates :fixture_id, presence: true, uniqueness: true
end
