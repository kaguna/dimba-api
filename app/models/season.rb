class Season < ApplicationRecord
  has_many :fixtures
  belongs_to :league
  has_many :leagues_teams
  has_many :teams, through: :leagues_teams
  
  validates :name, presence: true, allow_blank: false

  validates :name, uniqueness: { scope: :league_id, message: "Season name exists in this league!" }

  validates_uniqueness_of :league_id, conditions: -> { current }, message: "Season in progress!"

  
  scope :current, -> { where(current: true) }

  after_initialize :end_season!, if: :season_eligible_for_ending?

  def end_season!
    update!(current: false)
  end

  private

  def season_eligible_for_ending?
    fixtures.empty? ? false :
     (!fixtures.pluck(:played).include?(false) &&
      fixtures.order(:match_day).pluck(:match_day).last <= Date.today+15)
  end
end
