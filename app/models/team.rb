class Team < ApplicationRecord
  validates :name, presence: true
  has_many :players

  has_many :fixtures
end
