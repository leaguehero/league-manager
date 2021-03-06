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

ActiveRecord::Schema.define(version: 20160404024019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "stripe_plan_id"
    t.string   "customer_id"
    t.datetime "active_until"
    t.string   "subdomain"
  end

  create_table "dues", force: :cascade do |t|
    t.integer "player_id"
    t.boolean "paid"
    t.integer "league_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "team_one"
    t.integer  "team_two"
    t.integer  "winner"
    t.integer  "loser"
    t.string   "location"
    t.integer  "winner_score"
    t.integer  "loser_score"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "time"
    t.string   "date"
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "max_teams"
    t.integer  "max_players_per_team"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "subdomain"
    t.string   "admin_name"
    t.string   "admin_email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_id"
    t.boolean  "paid"
    t.integer  "price"
    t.string   "payment_option"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.integer  "price"
    t.string   "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pre_leagues", force: :cascade do |t|
    t.string   "league_name"
    t.string   "subdomain"
    t.integer  "max_teams"
    t.integer  "max_players_per_team"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "captain"
    t.integer  "asst_captain"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "coach"
    t.integer  "points_for"
    t.integer  "points_against"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "pre_league_id"
    t.string   "name"
    t.string   "stripe_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
