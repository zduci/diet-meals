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

ActiveRecord::Schema.define(:version => 20130514212221) do

  create_table "admins", :force => true do |t|
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

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "allowed_food_connections", :force => true do |t|
    t.integer  "diet_id",    :null => false
    t.integer  "food_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "allowed_food_connections", ["food_id", "diet_id"], :name => "index_allowed_foods_on_food_id_and_diet_id", :unique => true

  create_table "diets", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "restrictive", :null => false
  end

  create_table "food_connections", :force => true do |t|
    t.integer  "parent_food_id", :null => false
    t.integer  "child_food_id",  :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "food_connections", ["child_food_id"], :name => "index_food_connections_on_child_food_id"
  add_index "food_connections", ["parent_food_id", "child_food_id"], :name => "index_food_connections_on_parent_food_id_and_child_food_id", :unique => true
  add_index "food_connections", ["parent_food_id"], :name => "index_food_connections_on_parent_food_id"

  create_table "foods", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "foods", ["name"], :name => "index_foods_on_name"

  create_table "forbidden_food_connections", :force => true do |t|
    t.integer  "diet_id",    :null => false
    t.integer  "food_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forbidden_food_connections", ["food_id", "diet_id"], :name => "index_forbidden_food_connections_on_food_id_and_diet_id", :unique => true

  create_table "ingredients", :force => true do |t|
    t.integer  "food_id",                :null => false
    t.integer  "quantity",               :null => false
    t.integer  "unit_of_measurement_id", :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "recipe_id"
  end

  add_index "ingredients", ["food_id"], :name => "index_ingredients_on_food_id"
  add_index "ingredients", ["recipe_id"], :name => "index_ingredients_on_recipe_id"
  add_index "ingredients", ["unit_of_measurement_id"], :name => "index_ingredients_on_unit_of_measurement_id"

  create_table "recipes", :force => true do |t|
    t.text     "instructions", :null => false
    t.integer  "duration"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name",         :null => false
  end

  create_table "unit_of_measurements", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "short_name", :null => false
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
