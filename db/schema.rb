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

ActiveRecord::Schema.define(version: 2021_05_07_225236) do

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

end
