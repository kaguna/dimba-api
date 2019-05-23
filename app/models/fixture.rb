class Fixture < ApplicationRecord
  belongs_to :season
  belongs_to :result

  validates :away_team, presence: true
  validates :home_team, presence: true
end
