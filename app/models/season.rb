class Season < ApplicationRecord
  include MatchResults
  include Standing

  has_many :fixtures
  belongs_to :league
  has_many :leagues_teams
  has_many :teams, through: :leagues_teams
  has_one :season_standing
  
  validates :name, presence: true, allow_blank: false

  validates :name, uniqueness: { scope: :league_id, message: "Season name exists in this league!" }

  validates_uniqueness_of :league_id, conditions: -> { where(current: true) }, message: "Season in progress!", :on => :save

  
  scope :current, -> { where(current: true) }
  scope :archived, -> { where(current: false).order(created_at: :desc) }

  after_find :end_season!, if: :season_eligible_for_ending?

  def end_season!
    if season_standing.nil?
      transaction do
        SeasonStanding.create!(season_id: id, standing: table) unless league.friendly?
        update!(current: false)
      end
    end
  end

  private

  def match(match_id)
    MatchResults.get_match_results(match_id)
  end

  def matches
    fixtures&.played&.map do |match| 
      match(match&.id)
    end
  end

  def table
    { standing: Standing.league_season_standings(matches) }.to_json
  end

  def season_eligible_for_ending?
    fixtures.empty? ? false :
    (!fixtures.pluck(:played).include?(false) &&
    fixtures.order(:match_day).pluck(:match_day).last <= Rails.application.config.days_to_archive_season.ago)
  end
end
