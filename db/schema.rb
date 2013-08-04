# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130804141702) do

  create_table "active_admin_comments", force: true do |t|
    t.integer   "resource_id",   null: false
    t.string    "resource_type", null: false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authorizations", force: true do |t|
    t.string    "provider"
    t.string    "uid"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id"

  create_table "events", force: true do |t|
    t.string    "name"
    t.timestamp "date"
    t.text      "description"
    t.integer   "location_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "published"
    t.string    "slug"
    t.string    "label",       default: "hamburg"
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id"
  add_index "events", ["slug"], name: "index_events_on_slug", unique: true
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "highlights", force: true do |t|
    t.string    "description"
    t.string    "url"
    t.timestamp "start_at"
    t.timestamp "end_at"
    t.timestamp "created_at",                      null: false
    t.timestamp "updated_at",                      null: false
    t.string    "label",       default: "hamburg"
  end

  create_table "jobs", force: true do |t|
    t.string    "name"
    t.string    "url"
    t.integer   "location_id"
    t.timestamp "created_at",                      null: false
    t.timestamp "updated_at",                      null: false
    t.string    "label",       default: "hamburg"
  end

  add_index "jobs", ["location_id"], name: "index_jobs_on_location_id"

  create_table "likes", force: true do |t|
    t.integer   "user_id"
    t.integer   "topic_id"
    t.timestamp "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "locations", force: true do |t|
    t.string    "name"
    t.string    "url"
    t.string    "street"
    t.string    "house_number"
    t.string    "city"
    t.string    "zip"
    t.float     "lat"
    t.float     "long"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "company"
    t.string    "label",        default: "hamburg"
    t.string    "slug"
  end

  add_index "locations", ["id"], name: "index_locations_on_id"
  add_index "locations", ["slug"], name: "index_locations_on_slug", unique: true

  create_table "materials", force: true do |t|
    t.string    "name"
    t.text      "description"
    t.string    "url"
    t.integer   "user_id"
    t.integer   "event_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "materials", ["event_id"], name: "index_materials_on_event_id"
  add_index "materials", ["user_id"], name: "index_materials_on_user_id"

  create_table "participants", force: true do |t|
    t.integer   "user_id"
    t.integer   "event_id"
    t.boolean   "maybe"
    t.text      "comment"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "participants", ["event_id"], name: "index_participants_on_event_id"
  add_index "participants", ["user_id"], name: "index_participants_on_user_id"

  create_table "slugs", force: true do |t|
    t.string    "name"
    t.integer   "sluggable_id"
    t.integer   "sequence",                  default: 1, null: false
    t.string    "sluggable_type", limit: 40
    t.string    "scope"
    t.timestamp "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true
  add_index "slugs", ["sluggable_id", "sluggable_type"], name: "index_slugs_on_sluggable_id_and_sluggable_type"
  add_index "slugs", ["sluggable_id"], name: "index_slugs_on_sluggable_id"

  create_table "topics", force: true do |t|
    t.string    "name"
    t.text      "description"
    t.integer   "user_id"
    t.integer   "event_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "label",       default: "hamburg"
    t.string    "slug"
  end

  add_index "topics", ["event_id"], name: "index_topics_on_event_id"
  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "usergroups", force: true do |t|
    t.string    "name"
    t.string    "url"
    t.string    "twitter"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", force: true do |t|
    t.string    "nickname"
    t.string    "name"
    t.string    "image"
    t.string    "url"
    t.string    "location"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "github"
    t.boolean   "admin"
    t.boolean   "freelancer"
    t.boolean   "available"
    t.string    "slug"
    t.boolean   "hide_jobs",   default: false
    t.string    "twitter"
    t.string    "email"
  end

  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
