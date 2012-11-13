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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121113191723) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer   "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authorizations", :force => true do |t|
    t.string    "provider"
    t.string    "uid"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string    "name"
    t.timestamp "date"
    t.text      "description"
    t.integer   "location_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "published"
    t.string    "slug"
    t.string    "label",       :default => "hamburg"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true

  create_table "highlights", :force => true do |t|
    t.string    "description"
    t.string    "url"
    t.timestamp "start_at"
    t.timestamp "end_at"
    t.timestamp "created_at",                         :null => false
    t.timestamp "updated_at",                         :null => false
    t.string    "label",       :default => "hamburg"
  end

  create_table "jobs", :force => true do |t|
    t.string    "name"
    t.string    "url"
    t.integer   "location_id"
    t.timestamp "created_at",                         :null => false
    t.timestamp "updated_at",                         :null => false
    t.string    "label",       :default => "hamburg"
  end

  create_table "locations", :force => true do |t|
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
    t.string   "label",        :default => "hamburg"
    t.string   "slug"
  end

  add_index "locations", ["slug"], :name => "index_locations_on_slug", :unique => true

  create_table "materials", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.string    "url"
    t.integer   "user_id"
    t.integer   "event_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer   "user_id"
    t.integer   "event_id"
    t.boolean   "maybe"
    t.text      "comment"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string    "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "slugs", :force => true do |t|
    t.string    "name"
    t.integer   "sluggable_id"
    t.integer   "sequence",                     :default => 1, :null => false
    t.string    "sluggable_type", :limit => 40
    t.string    "scope"
    t.timestamp "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "topics", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.integer   "user_id"
    t.integer   "event_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "usergroups", :force => true do |t|
    t.string    "name"
    t.string    "url"
    t.string    "twitter"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
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
    t.boolean   "hide_jobs",   :default => false
  end

  add_index "users", ["nickname"], :name => "index_users_on_nickname", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "votes", :force => true do |t|
    t.integer   "wish_id"
    t.integer   "user_id"
    t.integer   "count"
    t.text      "comment"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "wishes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "done",        :default => false
    t.string   "slug"
    t.string   "label",       :default => "hamburg"
    t.integer  "votes_count", :default => 0
    t.integer  "stars",       :default => 0
  end

  add_index "wishes", ["slug"], :name => "index_wishes_on_slug", :unique => true

end
