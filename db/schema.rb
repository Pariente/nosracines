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

ActiveRecord::Schema.define(version: 2021_11_20_173655) do

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

  create_table "aliases", force: :cascade do |t|
    t.string "name"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
    t.index ["person_id"], name: "index_aliases_on_person_id"
  end

  create_table "document_files", force: :cascade do |t|
    t.string "url"
    t.text "transcript"
    t.text "translation_fr"
    t.string "language"
    t.text "comment"
    t.text "persons_position"
    t.string "original_format"
    t.string "color"
    t.bigint "document_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["document_id"], name: "index_document_files_on_document_id"
  end

  create_table "document_people", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_document_people_on_document_id"
    t.index ["person_id"], name: "index_document_people_on_person_id"
  end

  create_table "document_sources", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "source_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_document_sources_on_document_id"
    t.index ["source_id"], name: "index_document_sources_on_source_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "reference"
    t.string "location"
    t.bigint "fund_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "box"
    t.text "notes"
    t.boolean "privacy", default: false
    t.index ["fund_id"], name: "index_documents_on_fund_id"
  end

  create_table "event_documents", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "document_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_event_documents_on_document_id"
    t.index ["event_id"], name: "index_event_documents_on_event_id"
  end

  create_table "event_people", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_people_on_event_id"
    t.index ["person_id"], name: "index_event_people_on_person_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "date_start"
    t.date "date_end"
    t.text "story"
    t.text "comment"
    t.string "illustration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "privacy", default: false
  end

  create_table "family_links", force: :cascade do |t|
    t.integer "person_a_id"
    t.integer "person_b_id"
    t.string "link_a_to_b"
    t.string "link_b_to_a"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "funds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "location_documents", force: :cascade do |t|
    t.bigint "location_id"
    t.bigint "document_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_location_documents_on_document_id"
    t.index ["location_id"], name: "index_location_documents_on_location_id"
  end

  create_table "location_events", force: :cascade do |t|
    t.bigint "location_id"
    t.bigint "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_location_events_on_event_id"
    t.index ["location_id"], name: "index_location_events_on_location_id"
  end

  create_table "location_people", force: :cascade do |t|
    t.bigint "location_id"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_location_people_on_location_id"
    t.index ["person_id"], name: "index_location_people_on_person_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "illustration"
    t.string "address"
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.boolean "privacy", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "spouse_name"
    t.date "birth_date"
    t.date "death_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_pic"
    t.text "biography"
    t.string "gender"
    t.string "birth_place"
    t.string "death_place"
    t.text "notes"
    t.boolean "privacy", default: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.boolean "has_private_access", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aliases", "people"
  add_foreign_key "document_files", "documents"
  add_foreign_key "document_people", "documents"
  add_foreign_key "document_people", "people"
  add_foreign_key "document_sources", "documents"
  add_foreign_key "document_sources", "sources"
  add_foreign_key "documents", "funds"
  add_foreign_key "event_documents", "documents"
  add_foreign_key "event_documents", "events"
  add_foreign_key "event_people", "events"
  add_foreign_key "event_people", "people"
  add_foreign_key "location_documents", "documents"
  add_foreign_key "location_documents", "locations"
  add_foreign_key "location_events", "events"
  add_foreign_key "location_events", "locations"
  add_foreign_key "location_people", "locations"
  add_foreign_key "location_people", "people"
end
