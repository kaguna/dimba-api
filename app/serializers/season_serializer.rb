class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :current
  attribute :season_winner, if: :not_current

  # TODO: REMOVE THESE TWO LINES AFTER REFACTORING TEAM LEAGUES FIXTURES IN FE
  belongs_to :league
  has_many :fixtures

  def not_current
    !object.current
  end

  def season_winner
    JSON.parse(AllResult.standings(object.league_id, object.id))['standing'][0]
  end
end
