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

ActiveRecord::Schema.define(version: 20150311202421) do

  create_table "bonus_musics", force: true do |t|
    t.integer  "music_id",     null: false
    t.datetime "period_start", null: false
    t.datetime "period_end",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_scores", force: true do |t|
    t.integer  "music_id",   null: false
    t.integer  "difficulty", null: false
    t.float    "level",      null: false
    t.integer  "notes",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musics", force: true do |t|
    t.integer  "number",     null: false
    t.string   "text_id",    null: false
    t.string   "title",      null: false
    t.string   "subtitle"
    t.string   "sortkey",    null: false
    t.datetime "added_at",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_scores", force: true do |t|
    t.integer  "skill_id",   null: false
    t.integer  "status"
    t.boolean  "locked"
    t.integer  "rate"
    t.float    "rp"
    t.integer  "grade"
    t.integer  "combo"
    t.boolean  "ultimate"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id",                       null: false
    t.integer  "music_id",                      null: false
    t.string   "comment"
    t.integer  "best_difficulty", default: 0
    t.float    "best_rp",         default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",                       null: false
    t.string   "password",                       null: false
    t.string   "cxbid"
    t.string   "comment"
    t.float    "rp",               default: 0.0
    t.datetime "skill_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
