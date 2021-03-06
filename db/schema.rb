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

ActiveRecord::Schema.define(version: 20160804113659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "synopsis"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_adventures_on_user_id", using: :btree
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "adventure_id"
    t.integer  "parent_choice_id"
    t.boolean  "to_destroy"
    t.index ["adventure_id"], name: "index_chapters_on_adventure_id", using: :btree
  end

  create_table "choices", force: :cascade do |t|
    t.string   "option",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "chapter_id"
    t.index ["chapter_id"], name: "index_choices_on_chapter_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.string   "chapters"
    t.string   "choices"
    t.integer  "user_id"
    t.integer  "adventure_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["adventure_id"], name: "index_games_on_adventure_id", using: :btree
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree
  end

  add_foreign_key "adventures", "users"
  add_foreign_key "chapters", "adventures"
  add_foreign_key "choices", "chapters"
  add_foreign_key "games", "adventures"
  add_foreign_key "games", "users"
end
