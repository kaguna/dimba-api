class Fixture < ApplicationRecord
  belongs_to :season

  validates :away_team, presence: true
  validates :home_team, presence: true
end
