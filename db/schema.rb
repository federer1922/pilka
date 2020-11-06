# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_05_125131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string "team_1_name"
    t.string "team_2_name"
    t.string "match_result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches_users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "matches_id", null: false
    t.bigint "users_id", null: false
    t.index ["matches_id"], name: "index_matches_users_on_matches_id"
    t.index ["users_id"], name: "index_matches_users_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "goals_count"
    t.integer "match_count"
  end

  add_foreign_key "matches_users", "matches_users", column: "matches_id"
  add_foreign_key "matches_users", "matches_users", column: "users_id"
end
