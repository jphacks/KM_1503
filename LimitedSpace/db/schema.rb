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

ActiveRecord::Schema.define(version: 20151128152756) do

  create_table "data_files", force: true do |t|
    t.string   "path"
    t.integer  "size"
    t.integer  "space_id"
    t.integer  "download_sum"
    t.integer  "type"
    t.datetime "soft_destroyed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "real_path"
  end

  add_index "data_files", ["soft_destroyed_at"], name: "index_data_files_on_soft_destroyed_at"

  create_table "spaces", force: true do |t|
    t.string   "name",              limit: 100
    t.integer  "span",              limit: 3
    t.float    "lat"
    t.float    "lng"
    t.integer  "radius",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "soft_destroyed_at"
  end

  add_index "spaces", ["soft_destroyed_at"], name: "index_spaces_on_soft_destroyed_at"

  create_table "users", force: true do |t|
    t.integer  "space_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "soft_destroyed_at"
  end

  add_index "users", ["soft_destroyed_at"], name: "index_users_on_soft_destroyed_at"

end
