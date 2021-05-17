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

ActiveRecord::Schema.define(version: 2021_05_17_063327) do

  create_table "activities", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_activities_on_category"
    t.index ["name"], name: "index_activities_on_name"
  end

  create_table "activity_details", force: :cascade do |t|
    t.integer "visit_record_id", null: false
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["visit_record_id", "activity_id"], name: "index_activity_details_on_visit_record_id_and_activity_id", unique: true
  end

  create_table "belongs", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_belongs_on_name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.integer "key_person_id"
    t.integer "sales_end_id"
    t.float "latitude"
    t.float "longitude"
    t.integer "system", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_customers_on_address"
    t.index ["name"], name: "index_customers_on_name"
  end

  create_table "key_people", force: :cascade do |t|
    t.string "name", null: false
    t.text "career"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_key_people_on_name"
  end

  create_table "sales_ends", force: :cascade do |t|
    t.string "name", null: false
    t.integer "belong_id"
    t.string "post"
    t.string "telephone_number"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sales_ends_on_name"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "visit_record_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "deadline"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visit_records", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "key_person_id", null: false
    t.integer "belong_id", null: false
    t.integer "sales_end_id", null: false
    t.datetime "visit_datetime", null: false
    t.datetime "next_datetime"
    t.text "note"
    t.integer "rank", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
