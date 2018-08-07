Rails.application.routes.draw do
  scope "teams" do
    get "/" => "teams#show"
    post "/create" => "teams#create"
  end
end
