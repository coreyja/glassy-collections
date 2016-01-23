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

ActiveRecord::Schema.define(version: 20160123211203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "instagram_username"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "dabs", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "nail_id",      null: false
    t.integer  "milliseconds", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "dabs", ["nail_id"], name: "index_dabs_on_nail_id", using: :btree
  add_index "dabs", ["user_id"], name: "index_dabs_on_user_id", using: :btree

  create_table "nails", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "nails", ["user_id"], name: "index_nails_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "dabs", "nails"
  add_foreign_key "dabs", "users"
  add_foreign_key "nails", "users"
end
