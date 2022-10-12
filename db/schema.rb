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

ActiveRecord::Schema[7.0].define(version: 2022_10_12_220204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cash_flows", force: :cascade do |t|
    t.string "kind", null: false
    t.float "value", null: false
    t.string "category", null: false
    t.date "moved_at", null: false
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_cash_flows_on_member_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "reference_month", null: false
    t.integer "reference_year", null: false
    t.float "value", null: false
    t.string "category", null: false
    t.bigint "cash_flow_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_flow_id"], name: "index_invoices_on_cash_flow_id"
    t.index ["member_id", "reference_month", "reference_year"], name: "index_invoices_once_per_month", unique: true
    t.index ["member_id"], name: "index_invoices_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "state", null: false
    t.string "kind", null: false
    t.string "nickname"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_members_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "blood_type"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
