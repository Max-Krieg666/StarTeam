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

ActiveRecord::Schema.define(version: 20171125002500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "careers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "player_id"
    t.string   "team_title",                null: false
    t.integer  "age_begin",                 null: false
    t.integer  "age_end"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "careers", ["player_id"], name: "index_careers_on_player_id", using: :btree

  create_table "club_bases", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "team_id"
    t.string   "title",                         null: false
    t.integer  "level",           default: 1,   null: false
    t.integer  "capacity",        default: 20,  null: false
    t.integer  "training_fields", default: 1,   null: false
    t.float    "experience_up",   default: 0.0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "title"
    t.string   "title_en"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "country_id"
    t.string   "title",                     null: false
    t.integer  "current_stage"
    t.integer  "count",         default: 0
    t.integer  "status",        default: 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "game_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "game_id"
    t.uuid    "player_id"
    t.integer "kind"
    t.string  "minute"
  end

  create_table "game_players", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "game_id"
    t.uuid     "player_id"
    t.integer  "goals",           default: 0
    t.integer  "shots",           default: 0
    t.integer  "shots_at_target", default: 0
    t.integer  "fouls_committed", default: 0
    t.integer  "yellow_cards",    default: 0
    t.integer  "red_cards",       default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "game_statistics", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "game_id"
    t.integer  "home_goals"
    t.integer  "home_shots",            default: 0
    t.integer  "home_shots_at_target",  default: 0
    t.integer  "home_corners",          default: 0
    t.integer  "home_fouls_committed",  default: 0
    t.integer  "home_yellow_cards",     default: 0
    t.integer  "home_red_cards",        default: 0
    t.integer  "home_offsides",         default: 0
    t.integer  "home_ball_possession",  default: 0
    t.integer  "guest_goals"
    t.integer  "guest_shots",           default: 0
    t.integer  "guest_shots_at_target", default: 0
    t.integer  "guest_corners",         default: 0
    t.integer  "guest_fouls_committed", default: 0
    t.integer  "guest_yellow_cards",    default: 0
    t.integer  "guest_red_cards",       default: 0
    t.integer  "guest_offsides",        default: 0
    t.integer  "guest_ball_possession", default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "games", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "home_id"
    t.uuid     "guest_id"
    t.string   "tournament_id"
    t.boolean  "kind"
    t.integer  "tour"
    t.datetime "starting_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "games", ["guest_id"], name: "index_games_on_guest_id", using: :btree
  add_index "games", ["home_id"], name: "index_games_on_home_id", using: :btree

  create_table "leagues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "country_id"
    t.string   "title",                  null: false
    t.integer  "count",      default: 0
    t.integer  "status",     default: 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.boolean  "viewed",     default: false
    t.string   "title"
    t.integer  "kind"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "operations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "team_id"
    t.boolean  "kind"
    t.string   "title"
    t.float    "sum",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                  limit: 50,                 null: false
    t.integer  "country_id"
    t.integer  "position1",                                        null: false
    t.integer  "position2"
    t.integer  "real_position",                                    null: false
    t.float    "efficienty",                       default: 1.0
    t.integer  "talent",                                           null: false
    t.integer  "age",                                              null: false
    t.integer  "skill_level",                                      null: false
    t.float    "price",                                            null: false
    t.integer  "state",                            default: 0
    t.integer  "training_points",                  default: 0
    t.integer  "tackling",                         default: 0
    t.integer  "marking",                          default: 0
    t.integer  "positioning",                      default: 0
    t.integer  "heading",                          default: 0
    t.integer  "pressure",                         default: 0
    t.integer  "shot_accuracy",                    default: 0
    t.integer  "shot_power",                       default: 0
    t.integer  "dribbling",                        default: 0
    t.integer  "passing",                          default: 0
    t.integer  "carport",                          default: 0
    t.integer  "speed",                            default: 0
    t.integer  "endurance",                        default: 0
    t.integer  "reaction",                         default: 0
    t.integer  "aggression",                       default: 0
    t.integer  "creativity",                       default: 0
    t.uuid     "team_id"
    t.string   "special_skill1",        limit: 2
    t.integer  "num_sp_s1"
    t.string   "special_skill2",        limit: 2
    t.integer  "num_sp_s2"
    t.string   "special_skill3",        limit: 2
    t.integer  "num_sp_s3"
    t.integer  "number"
    t.integer  "season_games",                     default: 0
    t.integer  "all_games",                        default: 0
    t.integer  "season_goals",                     default: 0
    t.integer  "all_goals",                        default: 0
    t.integer  "season_passes",                    default: 0
    t.integer  "all_passes",                       default: 0
    t.integer  "season_conceded_goals",            default: 0
    t.integer  "all_conceded_goals",               default: 0
    t.integer  "season_autogoals",                 default: 0
    t.integer  "all_autogoals",                    default: 0
    t.integer  "season_yellow_cards",              default: 0
    t.integer  "all_yellow_cards",                 default: 0
    t.integer  "season_red_cards",                 default: 0
    t.integer  "all_red_cards",                    default: 0
    t.integer  "status",                           default: 0
    t.boolean  "basic",                            default: false
    t.boolean  "can_play",                         default: true
    t.integer  "games_missed",                     default: 0
    t.boolean  "injured",                          default: false
    t.boolean  "captain"
    t.integer  "morale",                           default: 5
    t.float    "physical_condition",               default: 1.0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "players", ["country_id"], name: "index_players_on_country_id", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "sponsors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",              limit: 30,                                        null: false
    t.integer  "specialization",                                                       null: false
    t.uuid     "team_id"
    t.decimal  "loyalty_factor",                precision: 3,  scale: 2, default: 1.0, null: false
    t.decimal  "cost_of_full_stake",            precision: 20, scale: 2,               null: false
    t.decimal  "win_prize",                     precision: 7,  scale: 2,               null: false
    t.decimal  "draw_prize",                    precision: 7,  scale: 2,               null: false
    t.decimal  "lost_prize",                    precision: 7,  scale: 2,               null: false
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "stadia", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",      limit: 100,               null: false
    t.integer  "capacity",               default: 200, null: false
    t.integer  "level",                  default: 1,   null: false
    t.uuid     "team_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "team_cups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "team_id"
    t.uuid    "cup_id"
    t.integer "division"
    t.integer "stage"
    t.integer "games",          default: 0
    t.integer "goals",          default: 0
    t.integer "goals_conceded", default: 0
  end

  add_index "team_cups", ["cup_id"], name: "index_team_cups_on_cup_id", using: :btree
  add_index "team_cups", ["team_id"], name: "index_team_cups_on_team_id", using: :btree

  create_table "team_leagues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "team_id"
    t.uuid    "league_id"
    t.integer "division"
    t.integer "place"
    t.integer "tour"
    t.integer "games",          default: 0
    t.integer "goals",          default: 0
    t.integer "goals_conceded", default: 0
    t.integer "wins",           default: 0
    t.integer "draws",          default: 0
    t.integer "loses",          default: 0
    t.integer "points",         default: 0
  end

  add_index "team_leagues", ["league_id"], name: "index_team_leagues_on_league_id", using: :btree
  add_index "team_leagues", ["team_id"], name: "index_team_leagues_on_team_id", using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "title",      limit: 30,                                             null: false
    t.decimal  "budget",                precision: 20, scale: 2, default: 250000.0, null: false
    t.integer  "fans",                                           default: 20,       null: false
    t.integer  "country_id"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  create_table "transfers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "player_id"
    t.uuid     "vendor_id"
    t.uuid     "purchaser_id"
    t.float    "cost",         null: false
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transfers", ["player_id"], name: "index_transfers_on_player_id", using: :btree
  add_index "transfers", ["purchaser_id"], name: "index_transfers_on_purchaser_id", using: :btree
  add_index "transfers", ["vendor_id"], name: "index_transfers_on_vendor_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "login",                  limit: 24,              null: false
    t.integer  "country_id"
    t.integer  "sex",                               default: 0
    t.date     "birthday"
    t.integer  "role",                              default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email",                             default: "", null: false
    t.string   "password_digest",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
