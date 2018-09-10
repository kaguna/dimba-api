Rails.application.routes.draw do
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
end
