Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope 'user' do
        post '/sign_up' => 'register#signup', as: 'register'
        get '/confirm_email' => 'register#confirm_email', as: 'confirm_email'
        post '/reset-password' => 'register#reset_password', as: 'reset_password'
        get '/show-password-reset-form' => 'register#show_password_reset_form', as: 'show_password_reset_form'
        post '/reset-password-email' => 'register#send_reset_password_token', as: 'send_reset_password_token'
        post '/login' => 'user_token#create', as: 'login'
        get '/search_user' => 'admins#index', as: 'search_user'
        get '/referees' => 'admins#get_referees', as: 'get_referees'
        get '/coaches' => 'admins#get_coaches', as: 'get_coaches'
        get '/officials' => 'admins#get_officials', as: 'get_officials'
        put '/update_user' => 'admins#update', as: 'update_user'
      end

      resources :teams do
        get '/home_results' => 'results#show_team_home_results', as: 'home_results'
        get '/away_results' => 'results#show_team_away_results', as: 'away_results'
        get '/home_fixtures' => 'fixtures#show_team_home_fixtures', as: 'home_fixtures'
        get '/away_fixtures' => 'fixtures#show_team_away_fixtures', as: 'away_fixtures'
        get '/transfers' => 'transfers#show_team_transfers', as: 'team_transfers'
        get '/h2h_matches' => 'fixtures#h2h_matches', as: 'h2h_matches'
        resources :players
      end

      resources :leagues do
        get '/matches' => 'results#index', as: 'season_results' # Current season matches/live
        get '/fixtures' => 'fixtures#index', as: 'season_fixtures'
        get '/standing' => 'league_standings#index', as: 'standing'
        get '/stats' => 'all_results#player_stats', as: 'top_scorer'
        resources :seasons do
          get '/generate_fixture' => 'fixtures#generate_fixture', as: 'gen_fixture'
          get '/archived_season' => 'season_standings#archived_season', as: 'archived'
          get '/season_matches' => 'seasons#season_matches', as: 'season_matches_results'
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
      post '/edit_fixture_squad' => 'fixture_squads#add_first_11', as: 'update_squad'

      resources :transfers, :events, :sponsor, :roles

      scope 'players' do
        get '/search' => 'players#search_player', as: 'player_search'
      end

      scope 'matches/:match_id' do
        put '/edit' => 'fixtures#update', as: 'edit_match'
        get '/results' => 'fixtures#show', as: 'results'
        post '/results' => 'results#create', as: 'add_results'
        get '/commentaries' => 'commentaries#index', as: 'commentaries'
        get '/commentaries/:id' => 'commentaries#show', as: 'commentary'
        put '/commentaries/:id' => 'commentaries#update', as: 'edit_commentary'
        post '/commentaries' => 'commentaries#create', as: 'add_commentaries'
        delete '/commentaries/:id' => 'commentaries#destroy', as: 'delete_commentary'

        get '/squads' => 'fixture_squads#index', as: 'squads'
        post '/squads/new' => 'fixture_squads#create', as: 'create_squads'
      end
    end
  end
end
