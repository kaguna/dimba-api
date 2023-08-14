class TransferSerializer < ActiveModel::Serializer
  attributes :id, :from_team, :to_team, :transferred_player, :transfer_date

  belongs_to :from_team, serializer: TeamSerializer
  belongs_to :to_team, serializer: TeamSerializer
  belongs_to :transferred_player, serializer: PlayerSerializer

  def transfer_date
    object.created_at
  end

  def from_team
    object.from_team
  end

  def to_team
    object.to_team
  end

  def transferred_player
    object.transferred_player
  end
end
