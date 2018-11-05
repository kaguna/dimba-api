Rails.application.routes.draw do
  scope "user" do
    post "/sign_up" => "register#signup"
    post "/login" => "user_token#create"
  end

  scope "teams" do
    get "/" => "teams#index"
    get "/:team_id" => "teams#show"
    post "/" => "teams#create"
    put "/:team_id" => "teams#update"
    delete "/:team_id" => "teams#destroy"
  end

  scope "team/:team_id" do
    get "/players" => "players#index"
    get "/player/:player_id" => "players#show"
    post "/player" => "players#create"
    put "/player/:player_id" => "players#update"
    delete "/player/:player_id" => "players#destroy"
  end

  scope "fixture/:fixture_id/commentaries" do
    get "/" => "commentaries#index"
    post "/" => "commentaries#create"
    put "/:commentary_id" => "commentaries#update"
    delete "/:commentary_id" => "commentaries#destroy"
  end

  scope "league/:league_id/fixtures" do
    get "/" => "fixtures#index"
    get "/fixture_auto_gen" => "fixtures#generate_fixture"
    post "/" => "fixtures#create"
    get "/:fixture_id" => "fixtures#show"
    put "/:fixture_id" => "fixtures#update"
    delete "/:fixture_id" => "fixtures#destroy"
  end

  scope "leagues" do
    get "/" => "leagues#index"
    post "/" => "leagues#create"
    get "/:league_id" => "leagues#show"
    put "/:league_id" => "leagues#update"
    delete "/:league_id" => "leagues#destroy"
  end

  scope "transfers" do
    get "/" => "transfer#index"
    post "/" => "transfer#create"
    get "/:player_id" => "transfer#show"
    put "/:transfer_id" => "transfer#update"
    delete "/:transfer_id" => "transfer#destroy"
  end

  scope "sponsors" do
    get "/" => "sponsor#index"
    post "/" => "sponsor#create"
    get "/:sponsor_id" => "sponsor#show"
    put "/:sponsor_id" => "sponsor#update"
    delete "/:sponsor_id" => "sponsor#destroy"
  end

  scope "league/:league_id/league_teams" do
    get "/" => "leagues_teams#index"
    post "/" => "leagues_teams#create"
    get "/:league_team_id" => "leagues_teams#show"
    put "/:league_team_id" => "leagues_teams#update"
    delete "/:league_team_id" => "leagues_teams#destroy"
  end

  scope "events" do
    get "/" => "events#index"
    post "/" => "events#create"
    get "/:event_id" => "events#show"
    put "/:event_id" => "events#update"
    delete "/:event_id" => "events#destroy"
  end

  scope "league/:leagues_id/fixture/:fixtures_id/team/:teams_id/squad" do
    get "/" => "fixture_squad#index"
    post "/" => "fixture_squad#create"
    get "/:fixture_squad_id" => "fixture_squad#show"
    put "/:fixture_squad_id" => "fixture_squad#update"
    delete "/:fixture_squad_id" => "fixture_squad#destroy"
  end
end
