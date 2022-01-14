class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :current
  attribute :season_winner, if: :not_current

  belongs_to :league
  has_many :fixtures

  def not_current
    !object.current
  end

  def season_winner
    JSON.parse(AllResult.standings(object.league_id, object.id))['standing'][0]
  end
end
