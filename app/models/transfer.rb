class Transfer < ApplicationRecord
  validates_presence_of :player_id,
                        :from_team_id, :to_team_id

  # validates :check_if_transfer_valid
  belongs_to :from_team, class_name: "Team", foreign_key: "from_team_id"
  belongs_to :to_team, class_name: "Team", foreign_key: "to_team_id"
  belongs_to :transferred_player, class_name: "Player", foreign_key: "player_id"
  
  after_save :change_default_team!

  private

  # def check_if_transfer_valid
  #   LeaguesTeam.exists?(team_id: self.from_team_id)
  #   raise "Cannot make this transfer now to this team!"
  # end 

  def change_default_team!
    player = Player.find_by(id: self.player_id)
    player.update!(team_id: self.to_team_id)
  end
end
