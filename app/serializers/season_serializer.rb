class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :current
  attribute :season_winner, if: :not_current

  belongs_to :league, if: :relevant?
  has_many :fixtures, if: :relevant?

  def not_current
    !object.current
  end

  def relevant?
    @instance_options[:relevant]
  end

  def season_winner
    # JSON.parse(AllResult.standings(object.league_id, object.id))['standing'][0]
    JSON.parse(object.season_standing.standing)['standing'][0]
  end
end
