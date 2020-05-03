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
        resources :seasons do
          get '/matches' => 'results#matches_results', as: 'season_results'
          get '/standing' => 'results#league_season_standing', as: 'standing'
          get '/stats' => 'results#player_stats', as: 'top_scorer'
          resources :fixtures do
            resources :teams do
              resources :fixture_squad
            end
          end
        end
        resources :leagues_teams
      end

      # resources :fixtures do
      #   resources :commentaries
      # end

      resources :transfer, :events, :sponsor

      scope 'league/:league_id/fixtures' do
        get '/fixture_auto_gen' => 'fixtures#generate_fixture', as: 'gen_fixture'
      end

      # Temporary here
      scope 'match/:fixture_id' do
        get '/results' => 'results#match_result', as: 'results'
        get '/commentaries' => 'commentaries#index', as: 'commentaries'
        get '/commentaries/:id' => 'commentaries#show', as: 'commentary'
        put '/commentaries/:id' => 'commentaries#update', as: 'edit_commentary'
        post '/commentaries' => 'commentaries#create', as: 'add_commentaries'
        delete '/commentaries/:id' => 'commentaries#destroy', as: 'delete_commentary'
      end
    end
  end
end
