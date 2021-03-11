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

ActiveRecord::Schema.define(version: 2021_03_11_110515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.float "price"
    t.date "from"
    t.date "to"
    t.bigint "yacht_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["yacht_id"], name: "index_bookings_on_yacht_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.bigint "equipment_type_id", null: false
    t.bigint "yacht_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["equipment_type_id"], name: "index_equipment_on_equipment_type_id"
    t.index ["yacht_id"], name: "index_equipment_on_yacht_id"
  end

  create_table "equipment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "yacht_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["yacht_id"], name: "index_favorites_on_yacht_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.decimal "lat"
    t.decimal "long"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.bigint "yacht_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["yacht_id"], name: "index_reviews_on_yacht_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", force: :cascade do |t|
    t.bigint "service_type_id", null: false
    t.bigint "yacht_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
    t.index ["yacht_id"], name: "index_services_on_yacht_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yachts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "booking_type"
    t.decimal "lat"
    t.decimal "long"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.integer "price_per_day"
    t.integer "bed_space", default: 0
    t.bigint "user_id", null: false
    t.string "address"
    t.index ["location_id"], name: "index_yachts_on_location_id"
    t.index ["user_id"], name: "index_yachts_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "yachts"
  add_foreign_key "equipment", "equipment_types"
  add_foreign_key "equipment", "yachts"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "yachts"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "yachts"
  add_foreign_key "services", "service_types"
  add_foreign_key "services", "yachts"
  add_foreign_key "yachts", "users"
end
