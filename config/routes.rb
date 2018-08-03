Rails.application.routes.draw do
  root 'home#show_all_teams'
  get 'index/home'
  get 'index/fixtures'
  get 'index/events'
  get 'index/summary'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
