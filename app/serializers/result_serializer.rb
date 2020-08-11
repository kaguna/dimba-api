class ResultSerializer < ActiveModel::Serializer
  attributes :fixture_id, :home_team, :away_team, :match_day
end
