# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_25_110038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commentaries", force: :cascade do |t|
    t.bigint "event_id"
    t.text "description"
    t.text "commentary_time"
    t.bigint "team_id"
    t.bigint "player_id"
    t.bigint "fixture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_in"
    t.index ["event_id"], name: "index_commentaries_on_event_id"
    t.index ["fixture_id"], name: "index_commentaries_on_fixture_id"
    t.index ["player_id"], name: "index_commentaries_on_player_id"
    t.index ["team_id"], name: "index_commentaries_on_team_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixture_squads", force: :cascade do |t|
    t.bigint "player_id"
    t.boolean "playing", default: true
    t.bigint "fixture_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "starting", default: false
    t.index ["fixture_id"], name: "index_fixture_squads_on_fixture_id"
    t.index ["player_id"], name: "index_fixture_squads_on_player_id"
    t.index ["team_id"], name: "index_fixture_squads_on_team_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "league_id"
    t.integer "center_referee_id"
    t.integer "right_side_referee_id"
    t.integer "left_side_referee_id"
    t.integer "season_id"
    t.datetime "match_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "played", default: false
  end

  create_table "leagues", force: :cascade do |t|
    t.text "title"
    t.text "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "official_id"
  end

  create_table "leagues_sponsors", force: :cascade do |t|
    t.integer "league_id"
    t.integer "sponsor_id"
    t.integer "duration"
    t.float "budget_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues_teams", force: :cascade do |t|
    t.integer "team_id"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "last_name"
    t.string "nick_name"
    t.text "id_number"
    t.date "dob"
    t.text "phone_number"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.bigint "fixture_id"
    t.integer "home_goals"
    t.integer "away_goals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_results_on_fixture_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "current", default: true
  end

  create_table "sponsors", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.text "contacts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "location"
    t.text "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coach_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "from_team_id"
    t.integer "to_team_id"
    t.integer "player_id"
    t.text "transfer_comment"
    t.float "transfer_budget"
    t.text "contract_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "role_id"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "commentaries", "events"
  add_foreign_key "commentaries", "fixtures"
  add_foreign_key "commentaries", "players"
  add_foreign_key "commentaries", "players", column: "player_in"
  add_foreign_key "commentaries", "teams"
  add_foreign_key "fixture_squads", "fixtures"
  add_foreign_key "fixture_squads", "players"
  add_foreign_key "fixture_squads", "teams"
  add_foreign_key "fixtures", "leagues"
  add_foreign_key "fixtures", "seasons"
  add_foreign_key "fixtures", "teams", column: "away_team_id"
  add_foreign_key "fixtures", "teams", column: "home_team_id"
  add_foreign_key "fixtures", "users", column: "center_referee_id"
  add_foreign_key "fixtures", "users", column: "center_referee_id"
  add_foreign_key "fixtures", "users", column: "left_side_referee_id"
  add_foreign_key "fixtures", "users", column: "left_side_referee_id"
  add_foreign_key "fixtures", "users", column: "right_side_referee_id"
  add_foreign_key "fixtures", "users", column: "right_side_referee_id"
  add_foreign_key "leagues", "users", column: "official_id"
  add_foreign_key "leagues_sponsors", "leagues"
  add_foreign_key "leagues_sponsors", "sponsors"
  add_foreign_key "leagues_teams", "leagues"
  add_foreign_key "leagues_teams", "seasons"
  add_foreign_key "leagues_teams", "teams"
  add_foreign_key "players", "teams"
  add_foreign_key "results", "fixtures"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "teams", "users", column: "coach_id"
  add_foreign_key "transfers", "players"
  add_foreign_key "transfers", "teams", column: "from_team_id"
  add_foreign_key "transfers", "teams", column: "to_team_id"
  add_foreign_key "users", "roles"
end
