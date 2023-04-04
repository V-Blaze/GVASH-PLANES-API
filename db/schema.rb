# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_31_094608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "planes", force: :cascade do |t|
    t.string "name"
    t.string "plane_type"
    t.text "description"
    t.string "image"
    t.integer "price"
    t.string "model"
    t.date "year_of_manufacture"
    t.time "life_span"
    t.float "fees"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_planes_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "date"
    t.time "duration"
    t.bigint "user_id", null: false
    t.bigint "plane_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plane_id"], name: "index_reservations_on_plane_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "planes", "users"
  add_foreign_key "reservations", "planes"
  add_foreign_key "reservations", "users"
end
