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

  create_table "bonus_musics", force: :cascade do |t|
    t.integer  "music_id",     limit: 4, null: false
    t.datetime "period_start",           null: false
    t.datetime "period_end",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_scores", force: :cascade do |t|
    t.integer  "music_id",   limit: 4,  null: false
    t.integer  "difficulty", limit: 4,  null: false
    t.float    "level",      limit: 24, null: false
    t.integer  "notes",      limit: 4,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musics", force: :cascade do |t|
    t.integer  "number",     limit: 4,   null: false
    t.string   "text_id",    limit: 255, null: false
    t.string   "title",      limit: 255, null: false
    t.string   "subtitle",   limit: 255
    t.string   "sortkey",    limit: 255, null: false
    t.datetime "added_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_scores", force: :cascade do |t|
    t.integer  "skill_id",   limit: 4,  null: false
    t.integer  "difficulty", limit: 4,  null: false
    t.integer  "status",     limit: 4
    t.boolean  "locked",     limit: 1
    t.integer  "rate",       limit: 4
    t.float    "rp",         limit: 24
    t.integer  "grade",      limit: 4
    t.integer  "combo",      limit: 4
    t.boolean  "ultimate",   limit: 1
    t.integer  "score",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: :cascade do |t|
    t.integer  "user_id",         limit: 4,                 null: false
    t.integer  "music_id",        limit: 4,                 null: false
    t.string   "comment",         limit: 255
    t.integer  "best_difficulty", limit: 4,   default: 0
    t.float    "best_rp",         limit: 24,  default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",         limit: 255,               null: false
    t.string   "password",         limit: 255,               null: false
    t.string   "cxbid",            limit: 255
    t.string   "comment",          limit: 255
    t.float    "rp",               limit: 24,  default: 0.0
    t.datetime "skill_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
