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

ActiveRecord::Schema.define(version: 20150111041208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.text     "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.text     "title"
    t.text     "description"
    t.text     "image_url"
    t.datetime "submitted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wins",         default: 0
    t.integer  "losses",       default: 0
    t.float    "rank",         default: 0.0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.json     "oauth"
    t.text     "avatar"
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.text     "voting_history", default: [],              array: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
