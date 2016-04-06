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

ActiveRecord::Schema.define(version: 20160329071859) do

  create_table "amexes", force: true do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "market"
    t.string   "country"
    t.string   "ipo"
    t.string   "sector"
    t.boolean  "alive"
    t.string   "list_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "symbol"
    t.string   "name"
    t.decimal  "bid"
    t.decimal  "year_high"
    t.decimal  "year_low"
  end

  create_table "lists", force: true do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "market"
    t.string   "country"
    t.string   "ipo"
    t.string   "sector"
    t.boolean  "alive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "list_type"
  end

  create_table "nyses", force: true do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "market"
    t.string   "country"
    t.string   "ipo"
    t.string   "sector"
    t.boolean  "alive"
    t.string   "list_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_infos", force: true do |t|
    t.string   "symbol"
    t.string   "name"
    t.decimal  "bid"
    t.decimal  "ask"
    t.decimal  "year_high"
    t.decimal  "year_low"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_user_lists", force: true do |t|
    t.integer  "lists_id"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stock_name"
  end

  add_index "stock_user_lists", ["lists_id"], name: "index_stock_user_lists_on_lists_id"
  add_index "stock_user_lists", ["users_id"], name: "index_stock_user_lists_on_users_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
