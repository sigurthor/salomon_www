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

ActiveRecord::Schema.define(:version => 20130818181917) do

  create_table "a2_brands", :id => false, :force => true do |t|
    t.string   "id"
    t.string   "name"
    t.string   "domains"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "a2_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "img"
    t.integer  "position"
    t.boolean  "visible"
    t.string   "ancestry"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "type"
    t.string   "brand"
    t.integer  "magento_id"
    t.string   "filters"
  end

  add_index "a2_categories", ["ancestry"], :name => "index_a2_categories_on_ancestry"
  add_index "a2_categories", ["slug"], :name => "index_a2_categories_on_slug"

  create_table "a2_colorables", :force => true do |t|
    t.string   "color_code"
    t.string   "colorable_type"
    t.string   "colorable_id"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "a2_colorables", ["color_code", "colorable_id", "colorable_type"], :name => "code_id_type", :unique => true

  create_table "a2_colors", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "brand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "a2_colors", ["code", "brand"], :name => "brand_colors", :unique => true

  create_table "a2_delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "a2_delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "a2_feeds", :force => true do |t|
    t.string   "source"
    t.string   "type"
    t.datetime "date"
    t.string   "item_id"
    t.string   "tags"
    t.string   "url"
    t.text     "json"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "a2_genders", :force => true do |t|
    t.string   "gender"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "a2_genders", ["gender", "slug"], :name => "index_a2_genders_on_gender_and_slug", :unique => true

  create_table "a2_job_types", :force => true do |t|
    t.string   "name"
    t.string   "parameters"
    t.string   "class_name"
    t.string   "method_name"
    t.boolean  "notify_by_email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "a2_jobs", :force => true do |t|
    t.integer  "job_type_id"
    t.string   "job_file"
    t.boolean  "notifi_by_email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "parameters"
  end

  create_table "a2_online_stores", :force => true do |t|
    t.string   "name"
    t.string   "img"
    t.string   "url"
    t.integer  "category_id"
    t.boolean  "visible"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "a2_product_color_variants", :force => true do |t|
    t.string   "sap"
    t.string   "color_1_code"
    t.string   "color_1_name"
    t.string   "model"
    t.boolean  "has_photos"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "article_code"
    t.string   "brand"
  end

  add_index "a2_product_color_variants", ["sap"], :name => "index_a2_product_color_variants_on_sap", :unique => true

  create_table "a2_product_families", :force => true do |t|
    t.string   "product_family_code"
    t.string   "product_family_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "brand"
  end

  add_index "a2_product_families", ["product_family_code"], :name => "index_a2_product_families_on_product_family_code", :unique => true

  create_table "a2_product_feature_types", :force => true do |t|
    t.integer  "feature_type_code"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "brand"
    t.integer  "position"
    t.string   "category"
    t.boolean  "show_in_category_overview"
  end

  add_index "a2_product_feature_types", ["feature_type_code"], :name => "index_a2_product_feature_types_on_feature_type_code", :unique => true

  create_table "a2_product_features", :force => true do |t|
    t.integer  "feature_code"
    t.integer  "feature_type_code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "brand"
    t.integer  "product_feature_type_id"
    t.integer  "position"
  end

  add_index "a2_product_features", ["feature_code"], :name => "index_a2_product_features_on_feature_code", :unique => true

  create_table "a2_product_images", :force => true do |t|
    t.string   "sap"
    t.string   "size_code"
    t.string   "s3_key"
    t.string   "img"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "brand"
    t.integer  "variant_code"
  end

