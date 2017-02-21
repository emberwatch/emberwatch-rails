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

ActiveRecord::Schema.define(version: 20170221172326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "publisher"
    t.string   "url"
    t.boolean  "payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date     "date"
    t.string   "name"
    t.string   "site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer  "old_id"
    t.string   "shortname"
    t.string   "name"
    t.string   "github"
    t.string   "slack"
    t.string   "twitter"
    t.string   "slideshare"
    t.string   "speakerdeck"
    t.string   "site"
    t.string   "company"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "screencasts", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.date     "date"
    t.text     "videos",     default: "--- []\n"
    t.string   "series"
    t.string   "price"
    t.string   "subtitle"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "talks", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "videos"
    t.string   "url"
    t.string   "slides"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutorials", force: :cascade do |t|
    t.string   "title"
    t.text     "urls"
    t.date     "date"
    t.string   "code"
    t.date     "date_updated"
    t.date     "date_created"
    t.text     "versions"
    t.string   "demo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
