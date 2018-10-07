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

ActiveRecord::Schema.define(version: 20180913110659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_authorizations_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.text     "description"
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.string   "label",       default: "hamburg"
    t.integer  "limit"
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "highlights", force: :cascade do |t|
    t.string   "description"
    t.string   "url"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "label",       default: "hamburg"
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "location_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "label",       default: "hamburg"
    t.index ["location_id"], name: "index_jobs_on_location_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "street"
    t.string   "house_number"
    t.string   "city"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "company"
    t.string   "label",        default: "hamburg"
    t.string   "wheelmap_id"
    t.index ["id"], name: "index_locations_on_id", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preview_type"
    t.string   "preview_code"
    t.integer  "topic_id"
    t.index ["event_id"], name: "index_materials_on_event_id", using: :btree
    t.index ["user_id"], name: "index_materials_on_user_id", using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "maybe"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_participants_on_event_id", using: :btree
    t.index ["user_id"], name: "index_participants_on_user_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label",         default: "hamburg"
    t.string   "proposal_type", default: "proposal"
    t.index ["event_id"], name: "index_topics_on_event_id", using: :btree
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "name"
    t.string   "image"
    t.string   "url"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github"
    t.boolean  "admin"
    t.boolean  "freelancer"
    t.boolean  "available"
    t.boolean  "hide_jobs",   default: false
    t.string   "twitter"
    t.string   "email"
    t.boolean  "super_admin", default: false
    t.string   "linkedin"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  end

end
