module FixturesControllerHelper

  def generate
    fixtures = []
    matches = Team.all.pluck(:name).combination(2).to_a.shuffle
    matches.each do |team|
      fixture = { home_team: team[0], away_team: team[1],
                  season: "#{Date.current.year}/#{Date.current.year + 1}",
                  match_day: rand(Time.now + 2.weeks..Time.now + 5.weeks) }
      fixtures.push(fixture)
    end
    fixtures
  end
end