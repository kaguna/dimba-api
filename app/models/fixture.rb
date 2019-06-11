class Fixture < ApplicationRecord
  validates :away_team, presence: true
  validates :home_team, presence: true
  belongs_to :league
  belongs_to :season
  has_one :result, dependent: :destroy
  has_many :fixture_squad, dependent: :destroy
  has_many :commentaries, dependent: :destroy
end
