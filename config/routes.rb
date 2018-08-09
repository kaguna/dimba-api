Rails.application.routes.draw do
  scope "teams" do
    get "/" => "teams#index"
    get "/show/:team_id" => "teams#show"
    post "/create" => "teams#create"
    put "/edit/:team_id" => "teams#update"
  end
end
