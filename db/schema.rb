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

ActiveRecord::Schema.define(version: 20150710140345) do

  create_table "club_bases", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "title",                         null: false
    t.integer  "level",           default: 1,   null: false
    t.integer  "capacity",        default: 20,  null: false
    t.integer  "training_fields", default: 1,   null: false
    t.float    "experience_up",   default: 0.1, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "club_bases", ["team_id"], name: "index_club_bases_on_team_id"

  create_table "countries", force: :cascade do |t|
    t.string   "title"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "player_in_teams", force: :cascade do |t|
    t.string   "name",                  limit: 50,                 null: false
    t.integer  "country_id"
    t.string   "position1",                                        null: false
    t.string   "position2"
    t.integer  "talent",                                           null: false
    t.integer  "age",                                              null: false
    t.integer  "skill_level",                                      null: false
    t.float    "price",                                            null: false
    t.integer  "team_id",                                          null: false
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
    t.string   "status",                limit: 30
    t.boolean  "basic"
    t.boolean  "can_play",                         default: true
    t.integer  "games_missed",                     default: 0
    t.integer  "injured",                          default: 0
    t.boolean  "captain"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "none",                             default: false
    t.integer  "pos"
  end

  add_index "player_in_teams", ["country_id"], name: "index_player_in_teams_on_country_id"
  add_index "player_in_teams", ["team_id"], name: "index_player_in_teams_on_team_id"

  create_table "players", force: :cascade do |t|
    t.string   "name",        limit: 50,                 null: false
    t.integer  "country_id"
    t.string   "position1",                              null: false
    t.string   "position2"
    t.integer  "talent",                                 null: false
    t.integer  "age",                                    null: false
    t.integer  "skill_level",                            null: false
    t.float    "price",                                  null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "inteam",                 default: false
  end

  add_index "players", ["country_id"], name: "index_players_on_country_id"

  create_table "sponsors", force: :cascade do |t|
    t.string   "title",              limit: 30,                                         null: false
    t.string   "specialization",     limit: 100,                                        null: false
    t.integer  "team_id"
    t.decimal  "loyalty_factor",                 precision: 3,  scale: 2, default: 1.0, null: false
    t.decimal  "cost_of_full_stake",             precision: 20, scale: 2,               null: false
    t.decimal  "win_prize",                      precision: 7,  scale: 2,               null: false
    t.decimal  "draw_prize",                     precision: 7,  scale: 2,               null: false
    t.decimal  "lost_prize",                     precision: 7,  scale: 2,               null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "sponsors", ["team_id"], name: "index_sponsors_on_team_id"

  create_table "stadia", force: :cascade do |t|
    t.string   "title",      limit: 100, null: false
    t.integer  "capacity",               null: false
    t.integer  "level",                  null: false
    t.integer  "team_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stadia", ["team_id"], name: "index_stadia_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",         limit: 30,                          null: false
    t.integer  "sponsor_id",                                        null: false
    t.integer  "stadium_id"
    t.integer  "club_basis_id"
    t.decimal  "budget",                   precision: 20, scale: 2, null: false
    t.integer  "fans",                                              null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "teams", ["club_basis_id"], name: "index_teams_on_club_basis_id"
  add_index "teams", ["sponsor_id"], name: "index_teams_on_sponsor_id"
  add_index "teams", ["stadium_id"], name: "index_teams_on_stadium_id"
  add_index "teams", ["user_id"], name: "index_teams_on_user_id"

  create_table "transfers", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "vendor_id"
    t.integer  "purchaser_id"
    t.float    "cost"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transfers", ["player_id"], name: "index_transfers_on_player_id"
  add_index "transfers", ["purchaser_id"], name: "index_transfers_on_purchaser_id"
  add_index "transfers", ["vendor_id"], name: "index_transfers_on_vendor_id"

  create_table "users", force: :cascade do |t|
    t.string   "login",               limit: 24, null: false
    t.integer  "team_id"
    t.string   "password_digest"
    t.integer  "country_id"
    t.string   "sex"
    t.date     "birthday"
    t.string   "mail",                           null: false
    t.integer  "role"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "users", ["team_id"], name: "index_users_on_team_id"

end
