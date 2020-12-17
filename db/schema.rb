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

ActiveRecord::Schema.define(version: 2020_11_30_144339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliases", force: :cascade do |t|
    t.string "name"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_aliases_on_person_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "reference"
    t.string "location"
    t.integer "privacy", default: 0
    t.bigint "fund_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fund_id"], name: "index_documents_on_fund_id"
  end

  create_table "documents_people", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_documents_people_on_document_id"
    t.index ["person_id"], name: "index_documents_people_on_person_id"
  end

  create_table "documents_sources", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "source_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id"], name: "index_documents_sources_on_document_id"
    t.index ["source_id"], name: "index_documents_sources_on_source_id"
  end

  create_table "files", force: :cascade do |t|
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
    t.index ["document_id"], name: "index_files_on_document_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "nee"
    t.date "birth_date"
    t.date "death_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "aliases", "people"
  add_foreign_key "documents", "funds"
  add_foreign_key "documents_people", "documents"
  add_foreign_key "documents_people", "people"
  add_foreign_key "documents_sources", "documents"
  add_foreign_key "documents_sources", "sources"
  add_foreign_key "files", "documents"
end
