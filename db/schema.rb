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

ActiveRecord::Schema.define(version: 20150228025442) do

  create_table "bonus_musics", force: true do |t|
    t.integer  "music_id",     null: false
    t.datetime "period_start", null: false
    t.datetime "period_end",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musics", force: true do |t|
    t.integer  "number",            null: false
    t.string   "text_id",           null: false
    t.string   "title",             null: false
    t.string   "subtitle"
    t.string   "sortkey",           null: false
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
    t.datetime "added_at",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id",              null: false
    t.integer  "music_id",             null: false
    t.integer  "difficulty1_status"
    t.boolean  "difficulty1_locked"
    t.integer  "difficulty1_rate"
    t.float    "difficulty1_rp"
    t.integer  "difficulty1_grade"
    t.integer  "difficulty1_combo"
    t.boolean  "difficulty1_ultimate"
    t.integer  "difficulty1_score"
    t.integer  "difficulty2_status"
    t.boolean  "difficulty2_locked"
    t.integer  "difficulty2_rate"
    t.float    "difficulty2_rp"
    t.integer  "difficulty2_grade"
    t.integer  "difficulty2_combo"
    t.boolean  "difficulty2_ultimate"
    t.integer  "difficulty2_score"
    t.integer  "difficulty3_status"
    t.boolean  "difficulty3_locked"
    t.integer  "difficulty3_rate"
    t.float    "difficulty3_rp"
    t.integer  "difficulty3_grade"
    t.integer  "difficulty3_combo"
    t.boolean  "difficulty3_ultimate"
    t.integer  "difficulty3_score"
    t.integer  "difficulty4_status"
    t.boolean  "difficulty4_locked"
    t.integer  "difficulty4_rate"
    t.float    "difficulty4_rp"
    t.integer  "difficulty4_grade"
    t.integer  "difficulty4_combo"
    t.boolean  "difficulty4_ultimate"
    t.integer  "difficulty4_score"
    t.integer  "difficulty5_status"
    t.boolean  "difficulty5_locked"
    t.integer  "difficulty5_rate"
    t.float    "difficulty5_rp"
    t.integer  "difficulty5_grade"
    t.integer  "difficulty5_combo"
    t.boolean  "difficulty5_ultimate"
    t.integer  "difficulty5_score"
    t.string   "comment"
    t.integer  "best_difficulty"
    t.float    "best_rp"
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
