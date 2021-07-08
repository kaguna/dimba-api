class FixtureSquadSerializer < ActiveModel::Serializer
  attributes :id, :player, :team, :playing, :starting

  def player
    {
      id: object.player.id,
      name: two_names,
      nick_name: object.player.nick_name
    }
  end

  def team
    {
      id: object.team_id
    }
  end

  def two_names
    "#{object.player.first_name} #{object.player.second_name}"
  end
end
