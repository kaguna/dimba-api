class FixtureSquadSerializer < ActiveModel::Serializer
  attributes :squad

  def squad
    {
      id: self.object.id,
      player: [self.object.player.id, self.object.player.nick_name],
      team: self.object.team.id,
      playing: self.object.playing
    }
  end
end
