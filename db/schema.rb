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

ActiveRecord::Schema.define(version: 20150608195357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string "name"
  end

  create_table "coaches", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", force: true do |t|
    t.string  "name"
    t.integer "start_grade"
    t.integer "end_grade"
    t.boolean "active",      default: true
  end

  create_table "event_summaries", force: true do |t|
    t.integer  "event_id"
    t.integer  "division_id"
    t.float    "avg_student_points"
    t.float    "avg_team_points"
    t.integer  "max_student_points"
    t.integer  "max_team_points"
    t.integer  "max_student_id"
    t.integer  "max_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.integer  "num_rounds"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indiv_standings", force: true do |t|
    t.integer  "position"
    t.integer  "student_id"
    t.integer  "team_id"
    t.integer  "division_id"
    t.integer  "total_points"
    t.integer  "lowest_score"
    t.integer  "adjusted_points"
    t.float    "accuracy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_students", force: true do |t|
    t.integer "organization_id"
    t.integer "student_id"
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "organizations", force: true do |t|
    t.string  "name"
    t.string  "short_name"
    t.string  "street_1"
    t.string  "street_2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.decimal "latitude"
    t.decimal "longitude"
    t.boolean "active",          default: true
    t.integer "primary_contact"
  end

  create_table "quiz_teams", force: true do |t|
    t.integer "quiz_id"
    t.integer "team_id"
    t.integer "position"
    t.integer "raw_score"
    t.integer "points"
    t.integer "failed_challenges", default: 0
    t.integer "place"
  end

  create_table "quizzes", force: true do |t|
    t.integer "division_id"
    t.integer "event_id"
    t.string  "room_num"
    t.integer "round_num"
    t.boolean "active",      default: true
    t.integer "category_id"
  end

  create_table "settings", force: true do |t|
    t.date    "roster_lock_date"
    t.boolean "drop_lowest_score"
    t.boolean "roster_lock_toggle"
    t.boolean "auto_promote_students"
    t.string  "area_name"
    t.string  "admin_name"
    t.string  "admin_email"
  end

  create_table "student_quizzes", force: true do |t|
    t.integer "student_id"
    t.integer "quiz_id"
    t.integer "num_correct"
    t.integer "num_attempts"
    t.integer "num_fouls"
    t.integer "score"
  end

  create_table "student_teams", force: true do |t|
    t.integer "student_id"
    t.integer "team_id"
    t.boolean "is_captain", default: false
    t.boolean "present",    default: true
    t.date    "start_date"
    t.date    "end_date"
    t.integer "seat"
  end

  create_table "students", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.integer "grade"
    t.boolean "active",     default: true
  end

  create_table "team_coaches", force: true do |t|
    t.integer "team_id"
    t.integer "coach_id"
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "team_standings", force: true do |t|
    t.integer  "position"
    t.integer  "team_id"
    t.string   "division_id"
    t.integer  "total_points"
    t.float    "accuracy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer "division_id"
    t.integer "organization_id"
    t.string  "name"
    t.boolean "active",          default: true
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "role"
    t.string   "password_digest"
    t.boolean  "active",                 default: true
    t.datetime "active_after"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "token_type"
  end

end
