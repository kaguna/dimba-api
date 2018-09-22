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

ActiveRecord::Schema.define(version: 2018_09_20_122946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "event_time"
    t.bigint "teams_id"
    t.bigint "players_id"
    t.bigint "fixtures_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixtures_id"], name: "index_events_on_fixtures_id"
    t.index ["players_id"], name: "index_events_on_players_id"
    t.index ["teams_id"], name: "index_events_on_teams_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "home_team"
    t.integer "away_team"
    t.text "season"
    t.date "match_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "teams_id"
    t.bigint "fixtures_id"
    t.integer "total_goals"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixtures_id"], name: "index_results_on_fixtures_id"
    t.index ["teams_id"], name: "index_results_on_teams_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "location"
    t.text "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "fixtures", column: "fixtures_id"
  add_foreign_key "events", "players", column: "players_id"
  add_foreign_key "events", "teams", column: "teams_id"
  add_foreign_key "fixtures", "teams", column: "away_team"
  add_foreign_key "fixtures", "teams", column: "home_team"
  add_foreign_key "players", "teams"
  add_foreign_key "results", "fixtures", column: "fixtures_id"
  add_foreign_key "results", "teams", column: "teams_id"
end
