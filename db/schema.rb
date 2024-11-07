# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_14_023728) do
  create_table "accounts", force: :cascade do |t|
    t.string "account_name"
    t.integer "tokens"
    t.integer "account_number"
    t.string "account_email"
    t.string "password_digest"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "acc_no"
  end

  create_table "comparable_properties", force: :cascade do |t|
    t.string "location"
    t.integer "size"
    t.string "category"
    t.integer "value"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.string "title"
    t.text "description"
    t.datetime "date_and_time"
    t.integer "status", default: 0
    t.string "action"
    t.string "icon"
    t.integer "priority", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "image"
    t.string "lr_no"
    t.string "location"
    t.string "category"
    t.string "analysis"
    t.text "description"
    t.string "title"
    t.integer "size"
    t.string "value"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_code"
    t.integer "amount"
    t.integer "account_number"
    t.string "account_name"
    t.string "payment_method"
    t.string "user_name"
    t.integer "account_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "phone_no"
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
