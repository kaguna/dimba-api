class Transfer < ApplicationRecord
  validates_presence_of :player_id,
                        :from_team_id, :to_team_id
end
