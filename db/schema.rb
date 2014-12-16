# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141211172458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dynasties", force: true do |t|
    t.integer "owner_id"
    t.string  "name"
    t.integer "week_number"
    t.integer "season_number"
    t.integer "user_id"
  end

  add_index "dynasties", ["user_id"], name: "index_dynasties_on_user_id", using: :btree

  create_table "games", force: true do |t|
    t.integer "week_number"
    t.integer "season_number"
    t.integer "broadcast"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "home_score"
    t.integer "away_score"
    t.integer "winner_id"
    t.integer "loser_id"
    t.integer "q1_home"
    t.integer "q1_away"
    t.integer "q2_home"
    t.integer "q2_away"
    t.integer "q3_home"
    t.integer "q3_away"
    t.integer "q4_home"
    t.integer "q4_away"
    t.integer "ot_home"
    t.integer "ot_away"
    t.integer "dynasty_id"
  end

  add_index "games", ["dynasty_id"], name: "index_games_on_dynasty_id", using: :btree

  create_table "players", force: true do |t|
    t.integer "season_number"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "position"
    t.integer "year"
    t.integer "overall"
    t.string  "hometown"
    t.integer "attempts"
    t.integer "completion"
    t.integer "interception"
    t.integer "touch_downs"
    t.integer "yards"
    t.integer "fumbles"
    t.integer "long"
    t.integer "catches"
    t.string  "team"
    t.integer "fga"
    t.integer "fgs"
    t.integer "points"
    t.integer "xpa"
    t.integer "xpm"
    t.integer "ff"
    t.integer "fr"
    t.integer "sacks"
    t.integer "tackles_for_loss"
    t.integer "tackles"
    t.integer "speed"
    t.integer "strength"
    t.integer "agility"
    t.integer "acceleration"
    t.integer "jumping"
    t.integer "awareness"
    t.integer "stamina"
    t.integer "injury"
    t.integer "break_tackle"
    t.integer "trucking"
    t.integer "elusiveness"
    t.integer "stif_farm"
    t.integer "spin_move"
    t.integer "juke_move"
    t.integer "carrying"
    t.integer "ball_carrier_vision"
    t.integer "pass_block"
    t.integer "run_block"
    t.integer "catching"
    t.integer "spectacular_catch"
    t.integer "catch_in_traffic"
    t.integer "route_running"
    t.integer "release"
    t.integer "tackle"
    t.integer "hit_power"
    t.integer "pursuit"
    t.integer "play_recognition"
    t.integer "power_moves"
    t.integer "finesse_moves"
    t.integer "block_shedding"
    t.integer "man_coverage"
    t.integer "zone_coverage"
    t.integer "press"
    t.integer "throw_power"
    t.integer "throw_accuracy"
    t.integer "kick_power"
    t.integer "kick_accuracy"
    t.integer "dynasty_id"
    t.integer "team_id"
  end

  add_index "players", ["dynasty_id"], name: "index_players_on_dynasty_id", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "prospects", force: true do |t|
    t.integer "season_number"
    t.string  "first_name"
    t.string  "last_name"
    t.integer "caliber"
    t.string  "status"
    t.string  "height"
    t.string  "position"
    t.integer "weight"
    t.integer "rank"
    t.string  "hometown"
    t.string  "speed_base"
    t.string  "strength_base"
    t.string  "agility_base"
    t.string  "acceleration_base"
    t.string  "jumping_base"
    t.string  "awareness_base"
    t.string  "stamina_base"
    t.string  "injury_base"
    t.string  "break_tackle_rushing"
    t.string  "trucking_rushing"
    t.string  "elusiveness_rushing"
    t.string  "stiff_arm_rushing"
    t.string  "spin_move_rushing"
    t.string  "juke_move_rushing"
    t.string  "carrying_rushing"
    t.string  "pass_block_blocking"
    t.string  "run_block_blocking"
    t.string  "impact_blocking_blocking"
    t.string  "catching_receiving"
    t.string  "spectacular_catch_receiving"
    t.string  "catch_in_traffic_receiving"
    t.string  "route_running_receiving"
    t.string  "release_receiving"
    t.string  "tackle_tackling"
    t.string  "hit_power_tackling"
    t.string  "pursuit_tackling"
    t.string  "play_recognition_tackling"
    t.string  "power_moves_blockingshedding"
    t.string  "finesse_moves_blockingshedding"
    t.string  "block_shedding_blockingshedding"
    t.string  "man_coverage_coverage"
    t.string  "zone_coverage_coverage"
    t.string  "press_coverage"
    t.string  "throw_power_passing"
    t.string  "throw_accuracy_passing"
    t.string  "kick_power_kicking"
    t.string  "kick_accuracy_kicking"
    t.string  "school_1"
    t.string  "school_2"
    t.string  "school_3"
    t.string  "school_4"
    t.string  "school_5"
    t.string  "school_6"
    t.string  "school_7"
    t.string  "school_8"
    t.string  "school_9"
    t.string  "school_10"
    t.integer "dynasty_id"
  end

  add_index "prospects", ["dynasty_id"], name: "index_prospects_on_dynasty_id", using: :btree

  create_table "rankings", force: true do |t|
    t.integer "season_number"
    t.integer "week_number"
    t.string  "poll_name"
    t.integer "rank"
    t.integer "previous_rank"
    t.integer "wins"
    t.integer "losses"
    t.float   "fpv"
    t.integer "points"
    t.integer "dynasty_id"
  end

  add_index "rankings", ["dynasty_id"], name: "index_rankings_on_dynasty_id", using: :btree

  create_table "teams", force: true do |t|
    t.string  "name"
    t.integer "season_number"
    t.string  "conference"
    t.string  "coach_id"
    t.string  "conference_record"
    t.integer "conference_standing"
    t.integer "division_standing"
    t.integer "wins"
    t.integer "losses"
    t.integer "pointsagainst"
    t.integer "pointsfor"
    t.float   "winpercent"
    t.integer "dynasty_id"
    t.integer "user_id"
  end

  add_index "teams", ["dynasty_id"], name: "index_teams_on_dynasty_id", using: :btree
  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "active_dynasties"
    t.integer  "seasons_completed"
    t.integer  "access_level"
    t.boolean  "played_game"
    t.integer  "recruiting_points"
    t.boolean  "auto_pilot"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
