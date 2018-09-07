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

ActiveRecord::Schema.define(version: 2018_09_07_072512) do

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.integer "topic_link1_id"
    t.integer "topic_link2_id"
    t.integer "topic_link3_id"
    t.integer "topic_link4_id"
    t.integer "topic_link5_id"
    t.integer "topic_link6_id"
    t.integer "topic_link7_id"
    t.integer "topic_link8_id"
    t.integer "followers_count", default: 0
    t.integer "links_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xplorer_maps", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "strength", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
