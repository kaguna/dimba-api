Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope "user" do
        post "/sign_up" => "register#signup", as: "register"
        post "/login" => "user_token#create", as: "login"
      end

      scope "teams" do
        get "/" => "teams#index", as: "teams"
        get "/:team_id" => "teams#show", as: "team"
        post "/" => "teams#create", as: "add_team"
        put "/:team_id" => "teams#update", as: "edit_team"
        delete "/:team_id" => "teams#destroy", as: "delete_team"
      end

      scope "team/:team_id" do
        get "/players" => "players#index", as: "players"
        get "/player/:player_id" => "players#show", as: "player"
        post "/player" => "players#create", as: "add_player"
        put "/player/:player_id" => "players#update", as: "edit_player"
        delete "/player/:player_id" => "players#destroy", as: "delete_player"
      end

      scope "fixture/:fixture_id/commentaries" do
        get "/" => "commentaries#index", as: "game_commentaries"
        post "/" => "commentaries#create", as: "add_commentary"
        put "/:commentary_id" => "commentaries#update", as: "edit_commentary"
        delete "/:commentary_id" => "commentaries#destroy", as: "delete_commentary"
      end

      scope "league/:league_id/fixtures" do
        get "/" => "fixtures#index", as: "fixtures"
        get "/fixture_auto_gen" => "fixtures#generate_fixture", as: "gen_fixture"
        post "/" => "fixtures#create", as: "add_fixtures"
        get "/:fixture_id" => "fixtures#show", as: "show_fixture"
        put "/:fixture_id" => "fixtures#update", as: "edit_fixture"
        delete "/:fixture_id" => "fixtures#destroy", as: "delete_fixture"
      end

      scope "leagues" do
        get "/" => "leagues#index", as: "leagues"
        post "/" => "leagues#create", as: "add_league"
        get "/:league_id" => "leagues#show", as: "league"
        put "/:league_id" => "leagues#update", as: "edit_league"
        delete "/:league_id" => "leagues#destroy", as: "delete_league"
      end

      scope "transfers" do
        get "/" => "transfer#index", as: "all_transfers"
        post "/" => "transfer#create", as: "transfer"
        get "/:player_id" => "transfer#show", as: "show_transfer"
        put "/:transfer_id" => "transfer#update", as: "edit_transfer"
        delete "/:transfer_id" => "transfer#destroy", as: "delete_transfer"
      end

      scope "sponsors" do
        get "/" => "sponsor#index", as: "sponsors"
        post "/" => "sponsor#create", as: "add_sponsor"
        get "/:sponsor_id" => "sponsor#show", as: "sponsor"
        put "/:sponsor_id" => "sponsor#update", as: "edit_sponsor"
        delete "/:sponsor_id" => "sponsor#destroy", as: "delete_sponsor"
      end

      scope "league/:league_id/league_teams" do
        get "/" => "leagues_teams#index", as: "league_teams"
        post "/" => "leagues_teams#create", as: "add_team_to_league"
        get "/:league_team_id" => "leagues_teams#show", as: "league_team"
        put "/:league_team_id" => "leagues_teams#update", as: "edit_league_team"
        delete "/:league_team_id" => "leagues_teams#destroy", as: "delete_league_team"
      end

      scope "events" do
        get "/" => "events#index", as: "events"
        post "/" => "events#create", as: "add_event"
        get "/:event_id" => "events#show", as: "event"
        put "/:event_id" => "events#update", as: "edit_event"
        delete "/:event_id" => "events#destroy", as: "delete_event"
      end
    
      scope "league/:leagues_id/fixture/:fixtures_id/team/:teams_id/squad" do
        get "/" => "fixture_squad#index", as: "fixture_squads"
        post "/" => "fixture_squad#create", as: "add_fixture_squad"
        get "/:fixture_squad_id" => "fixture_squad#show", as: "fixture_squad"
        put "/:fixture_squad_id" => "fixture_squad#update", as: "edit_fixture_squad"
        delete "/:fixture_squad_id" => "fixture_squad#destroy", as: "delete_fixture_squad"
      end

      scope "fixture/:fixture_id/results" do
        get "/" => "results#index", as: "results"
        post "/" => "results#create", as: "add_results"
        get "/:result_id" => "results#show", as: "result"
        put "/:result_id" => "results#update", as: "edit_result"
        delete "/:result_id" => "results#destroy", as: "delete_result"
      end
    end
  end
end
