Rails.application.routes.draw do
  root 'index#login'

  scope "teams" do
    get "/" => "teams#show_all_teams"
    post "/create_new_team" => "teams#create_new_team"
  end
end
