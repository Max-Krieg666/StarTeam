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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "club_bases", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "team_id"
    t.string   "title",                         null: false
    t.integer  "level",           default: 1,   null: false
    t.integer  "capacity",        default: 20,  null: false
    t.integer  "training_fields", default: 1,   null: false
    t.float    "experience_up",   default: 0.1, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "club_bases", ["team_id"], name: "index_club_bases_on_team_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "title"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "players", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                  limit: 50,                    null: false
    t.integer  "country_id"
    t.integer  "position1",                                           null: false
    t.integer  "position2"
    t.integer  "talent",                                              null: false
    t.integer  "age",                                                 null: false
    t.integer  "skill_level",                                         null: false
    t.float    "price",                                               null: false
    t.integer  "state",                            default: 0
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
    t.string   "status",                limit: 30, default: "active"
    t.boolean  "basic",                            default: false
    t.boolean  "can_play",                         default: true
    t.integer  "games_missed",                     default: 0
    t.boolean  "injured",                          default: false
    t.boolean  "captain"
    t.float    "morale"
    t.float    "physical_condition"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "players", ["country_id"], name: "index_players_on_country_id", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "sponsors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",              limit: 30,                                         null: false
    t.string   "specialization",     limit: 100,                                        null: false
    t.uuid     "team_id"
    t.decimal  "loyalty_factor",                 precision: 3,  scale: 2, default: 1.0, null: false
    t.decimal  "cost_of_full_stake",             precision: 20, scale: 2,               null: false
    t.decimal  "win_prize",                      precision: 7,  scale: 2,               null: false
    t.decimal  "draw_prize",                     precision: 7,  scale: 2,               null: false
    t.decimal  "lost_prize",                     precision: 7,  scale: 2,               null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "sponsors", ["team_id"], name: "index_sponsors_on_team_id", using: :btree

  create_table "stadia", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",      limit: 100, null: false
    t.integer  "capacity",               null: false
    t.integer  "level",                  null: false
    t.uuid     "team_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stadia", ["team_id"], name: "index_stadia_on_team_id", using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "title",      limit: 30,                          null: false
    t.decimal  "budget",                precision: 20, scale: 2, null: false
    t.integer  "fans",                                           null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "transfers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "player_id"
    t.uuid     "vendor_id"
    t.uuid     "purchaser_id"
    t.float    "cost",         null: false
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transfers", ["player_id"], name: "index_transfers_on_player_id", using: :btree
  add_index "transfers", ["purchaser_id"], name: "index_transfers_on_purchaser_id", using: :btree
  add_index "transfers", ["vendor_id"], name: "index_transfers_on_vendor_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "login",               limit: 24, null: false
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

end
