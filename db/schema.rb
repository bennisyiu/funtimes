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

ActiveRecord::Schema.define(version: 2020_08_10_130152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "itinerary_id", null: false
    t.bigint "evint_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evint_id"], name: "index_activities_on_evint_id"
    t.index ["itinerary_id"], name: "index_activities_on_itinerary_id"
  end

  create_table "evints", force: :cascade do |t|
    t.string "title"
    t.string "evint_link"
    t.string "venue"
    t.string "address"
    t.string "category"
    t.string "time"
    t.string "area"
    t.string "description"
    t.string "image_link"
    t.string "date"
    t.string "phone"
    t.string "wechatid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_guests_on_activity_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_itineraries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "open_id"
    t.string "name"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "activities", "evints"
  add_foreign_key "activities", "itineraries"
  add_foreign_key "guests", "activities"
  add_foreign_key "guests", "users"
  add_foreign_key "itineraries", "users"
end
