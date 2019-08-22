Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope 'league/:league_id/season/:season_id' do
        get '/table' => 'league_standings#show', as: 'standings'
      end

      scope 'user' do
        post '/sign_up' => 'register#signup', as: 'register'
        post '/login' => 'user_token#create', as: 'login'
      end

      resources :teams do
        resources :players
      end

      resources :leagues do
        resources :fixtures do
          resources :teams do
            resources :fixture_squad
          end
        end
        resources :leagues_teams
      end

      resources :fixtures do
        resources :commentaries
      end

      resources :transfer, :events, :sponsor

      scope 'league/:league_id/fixtures' do
        get '/fixture_auto_gen' => 'fixtures#generate_fixture', as: 'gen_fixture'
      end

      # Temporary here
      scope 'fixture/:fixture_id/results' do
        get '/' => 'results#index', as: 'results'
        post '/' => 'results#create', as: 'add_results'
        get '/:result_id' => 'results#show', as: 'result'
        put '/:result_id' => 'results#update', as: 'edit_result'
        delete '/:result_id' => 'results#destroy', as: 'delete_result'
      end
    end
  end
end
