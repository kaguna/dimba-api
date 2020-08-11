Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope 'user' do
        post '/sign_up' => 'register#signup', as: 'register'
        post '/login' => 'user_token#create', as: 'login'
      end

      resources :teams do
        resources :players
      end

      resources :leagues do
        get '/matches' => 'results#index', as: 'season_results'
        get '/fixtures' => 'fixtures#index', as: 'season_fixtures'
        get '/standing' => 'league_standings#index', as: 'standing'
        get '/stats' => 'all_results#player_stats', as: 'top_scorer'
        resources :seasons do
          get '/generate_fixture' => 'fixtures#generate_fixture', as: 'gen_fixture'
          resources :league_teams
          resources :fixtures
        end
      end

      resources :fixtures do
        resources :teams do
          resources :fixture_squad
        end
      end

      get '/all_fixtures' => 'results#all_incoming_matches', as: 'current_season_matches'

      resources :transfer, :events, :sponsor

      scope 'matches/:match_id' do
        get '/results' => 'all_results#match_result', as: 'results'
        get '/commentaries' => 'commentaries#index', as: 'commentaries'
        get '/commentaries/:id' => 'commentaries#show', as: 'commentary'
        put '/commentaries/:id' => 'commentaries#update', as: 'edit_commentary'
        post '/commentaries' => 'commentaries#create', as: 'add_commentaries'
        delete '/commentaries/:id' => 'commentaries#destroy', as: 'delete_commentary'

        get '/squads' => 'fixture_squads#index', as: 'squads'
      end
    end
  end
end
