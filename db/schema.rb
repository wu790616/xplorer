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

ActiveRecord::Schema.define(version: 2018_09_07_165933) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.integer "time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer "user_id"
    t.integer "reply_id"
    t.integer "topic_tag_id"
    t.string "title"
    t.text "content"
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "views_count", default: 0
    t.integer "bookmarks_count", default: 0
    t.integer "shares_count", default: 0
    t.boolean "draft", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "content"
    t.string "link"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skillships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_followships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.string "progress", default: "init"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_tagships", force: :cascade do |t|
    t.integer "issue_id"
    t.integer "topic_id"
    t.string "progress", default: "init"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_viewships", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "user_id"
    t.integer "topic_viewship_id"
    t.string "progress", default: "init"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "user_followships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_x_maps", force: :cascade do |t|
    t.integer "user_id"
    t.integer "from_id"
    t.integer "to_id"
    t.integer "strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "avatar"
    t.text "introduction"
    t.string "role"
    t.integer "followers_count", default: 0
    t.boolean "contact_privacy", default: false
    t.boolean "topic_follow_privacy", default: false
    t.boolean "issue_book_privacy", default: false
    t.string "fb_uid"
    t.string "fb_token"
    t.string "google_uid"
    t.string "google_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "xplorer_maps", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "strength", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
