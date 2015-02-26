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

ActiveRecord::Schema.define(version: 20150225163036) do

  create_table "musics", force: true do |t|
    t.integer  "number"
    t.string   "text_id"
    t.string   "title"
    t.string   "sortkey"
    t.float    "difficulty1_level"
    t.float    "difficulty2_level"
    t.float    "difficulty3_level"
    t.float    "difficulty4_level"
    t.float    "difficulty5_level"
    t.integer  "difficulty1_notes"
    t.integer  "difficulty2_notes"
    t.integer  "difficulty3_notes"
    t.integer  "difficulty4_notes"
    t.integer  "difficulty5_notes"
    t.datetime "added_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",         null: false
    t.string   "password",         null: false
    t.string   "cxbid"
    t.string   "comment"
    t.float    "rp"
    t.datetime "skill_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
