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

ActiveRecord::Schema.define(version: 20140121000457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "api_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_username"
  end

  add_index "api_accounts", ["api_id"], name: "index_api_accounts_on_api_id", using: :btree
  add_index "api_accounts", ["user_id"], name: "index_api_accounts_on_user_id", using: :btree

  create_table "apis", force: true do |t|
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",  default: "default.jpg"
  end

  create_table "goals", force: true do |t|
    t.integer  "user_id"
    t.integer  "target"
    t.integer  "period"
    t.string   "period_type"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pledge"
    t.integer  "api_account_id"
    t.boolean  "active",         default: true
    t.string   "language"
    t.string   "commit_type"
  end

  add_index "goals", ["api_account_id"], name: "index_goals_on_api_account_id", using: :btree
  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.integer  "target"
    t.boolean  "twitter",       default: false
    t.boolean  "email",         default: false
    t.boolean  "sms",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "day_deadline"
    t.string   "time_deadline"
    t.date     "start_date"
    t.boolean  "active",        default: true
  end

  add_index "reminders", ["goal_id"], name: "index_reminders_on_goal_id", using: :btree
  add_index "reminders", ["user_id"], name: "index_reminders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "phone_number"
  end

end
