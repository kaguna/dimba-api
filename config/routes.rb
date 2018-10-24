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
end
