class Fixture < ApplicationRecord
  validates :away_team, presence: true
  validates :home_team, presence: true

end
