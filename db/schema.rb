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

ActiveRecord::Schema.define(:version => 20130109225003) do

  create_table "component_items", :force => true do |t|
    t.integer  "component_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.float    "cost"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "components", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "recipe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.float    "cost"
    t.float    "sale"
    t.float    "profit"
    t.integer  "list_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "listing_fee"
    t.integer  "transaction_fee"
    t.text     "tmp_response"
  end

  create_table "lists", :force => true do |t|
    t.integer "profession_id"
    t.integer "user_id"
    t.string  "name"
  end

  create_table "professions", :force => true do |t|
    t.string "name"
  end

  create_table "recipes", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.float    "cost"
    t.float    "sale"
    t.integer  "profession_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "test_items", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
