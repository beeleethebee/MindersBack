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

ActiveRecord::Schema.define(version: 2021_07_23_114923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "patient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_categories_on_patient_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.datetime "schedule_time"
    t.bigint "therapist_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "note"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
    t.index ["therapist_id"], name: "index_consultations_on_therapist_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "location"
    t.string "context"
    t.datetime "time"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_entries_on_patient_id"
  end

  create_table "entry_categories", force: :cascade do |t|
    t.bigint "entry_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_entry_categories_on_category_id"
    t.index ["entry_id"], name: "index_entry_categories_on_entry_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "therapist_id"
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true
    t.index ["therapist_id"], name: "index_patients_on_therapist_id"
    t.index ["uid", "provider"], name: "index_patients_on_uid_and_provider", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "positivity", default: 5
    t.index ["patient_id"], name: "index_statuses_on_patient_id"
  end

  create_table "therapists", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_therapists_on_email", unique: true
    t.index ["reset_password_token"], name: "index_therapists_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "patients"
  add_foreign_key "consultations", "patients"
  add_foreign_key "consultations", "therapists"
  add_foreign_key "entries", "patients"
  add_foreign_key "entry_categories", "categories"
  add_foreign_key "entry_categories", "entries"
  add_foreign_key "patients", "therapists"
  add_foreign_key "statuses", "patients"
end
