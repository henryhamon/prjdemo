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

ActiveRecord::Schema.define(version: 20161209130100) do

  create_table "notes", force: :cascade do |t|
    t.string   "state"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "finished_at"
    t.datetime "archived_at"
  end

  add_index "notes", ["project_id"], name: "index_notes_on_project_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "state"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.string   "client"
  end

  add_index "projects", ["client"], name: "index_projects_on_client"
  add_index "projects", ["name"], name: "index_projects_on_name"

end
