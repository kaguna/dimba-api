namespace :app do
  desc "populate all away teams in one column team_id"
  task :populate_away_teams_ids_to_team_id do
    puts Fixture.all
  end
end
