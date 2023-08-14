class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :current
  attribute :season_winner, if: :not_current_not_friendly

  belongs_to :league, if: :relevant?
  has_many :fixtures, if: :relevant?

  def not_current_not_friendly
    !object.current && !object.league.friendly?
  end

  def relevant?
    @instance_options[:relevant]
  end

  def season_winner
    JSON.parse(object.season_standing.standing)['standing'][0]
  end
end
