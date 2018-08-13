Rails.application.routes.draw do
  scope "teams" do
    get "/" => "teams#index"
    get "/:team_id" => "teams#show"
    post "/" => "teams#create"
    put "/:team_id" => "teams#update"
    delete "/:team_id" => "teams#destroy"
  end
end
