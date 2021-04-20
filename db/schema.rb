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

ActiveRecord::Schema.define(version: 2021_01_13_033955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.text "description"
    t.integer "location_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "published"
    t.string "label", default: "hamburg"
    t.integer "limit"
    t.integer "github_issue"
    t.text "attendee_information"
    t.string "remote_url"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "highlights", id: :serial, force: :cascade do |t|
    t.string "description"
    t.string "url"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", default: "hamburg"
  end

  create_table "jobs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", default: "hamburg"
    t.index ["location_id"], name: "index_jobs_on_location_id"
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "street"
    t.string "house_number"
    t.string "city"
    t.string "zip"
    t.float "lat"
    t.float "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "company"
    t.string "label", default: "hamburg"
    t.string "wheelmap_id"
    t.boolean "virtual", default: false
    t.index ["id"], name: "index_locations_on_id"
  end

  create_table "materials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "preview_type"
    t.string "preview_code"
    t.integer "topic_id"
    t.index ["event_id"], name: "index_materials_on_event_id"
    t.index ["user_id"], name: "index_materials_on_user_id"
  end

  create_table "participants", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.boolean "maybe"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "label", default: "hamburg"
    t.string "proposal_type", default: "proposal"
    t.integer "github_issue"
    t.index ["event_id"], name: "index_topics_on_event_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "nickname"
    t.string "name"
    t.string "image"
    t.string "url"
    t.string "location"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "github"
    t.boolean "admin"
    t.boolean "freelancer"
    t.boolean "available"
    t.boolean "hide_jobs", default: false
    t.string "twitter"
    t.string "email"
    t.boolean "super_admin", default: false
    t.string "linkedin"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

end
