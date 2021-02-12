class Season < ApplicationRecord
  validates :name, presence: true, allow_blank: false

  validates :name, uniqueness: { scope: :league_id, message: "Season name exists in this league!" }

  validates_uniqueness_of :league_id, conditions: -> { current }, message: "Season in progress!"

  has_many :fixtures
  belongs_to :league
  has_many :leagues_teams
  has_many :teams, through: :leagues_teams
  
  scope :current, -> { where(current: true) }
end
