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

  scope "fixture/:fixture_id/events" do
    get "/" => "events#index"
    post "/" => "events#create"
    put "/:event_id" => "events#update"
    delete "/:event_id" => "events#destroy"
  end

  scope "fixtures" do
    get "/" => "fixtures#index"
    get "/:league_id/fixture_auto_gen" => "fixtures#generate_fixture"
    post "/" => "fixtures#create"
    get "/:fixture_id" => "fixtures#show"
    put "/:fixture_id" => "fixtures#update"
    delete "/:fixture_id" => "fixtures#destroy"
  end
end
