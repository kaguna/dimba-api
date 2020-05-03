class FixtureSquadSerializer < ActiveModel::Serializer
  attributes :id, :player, :team_id, :playing

  def player
  {
    id: object.player.id,
    name: object.player.nick_name
  }
  end
end
