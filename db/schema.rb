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

ActiveRecord::Schema.define(version: 20170920022327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completed_lists_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_completed_lists_items_on_item_id"
    t.index ["user_id"], name: "index_completed_lists_items_on_user_id"
  end

  create_table "friends_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id", "user_id"], name: "index_friends_users_on_friend_id_and_user_id", unique: true
    t.index ["user_id", "friend_id"], name: "index_friends_users_on_user_id_and_friend_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "date_completed"
    t.bigint "user_id", null: false
    t.index ["date_completed", "completed"], name: "index_items_on_date_completed_and_completed"
    t.index ["list_id"], name: "index_items_on_list_id"
    t.index ["title"], name: "index_items_on_title", unique: true
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: false, null: false
    t.datetime "due_date"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "lists_users", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "member", null: false
    t.index ["list_id"], name: "index_lists_users_on_list_id"
    t.index ["role"], name: "index_lists_users_on_role"
    t.index ["user_id"], name: "index_lists_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name", null: false
    t.string "profile_picture"
    t.boolean "admin", default: false, null: false
    t.datetime "deleted_at"
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

end
