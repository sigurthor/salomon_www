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

ActiveRecord::Schema.define(:version => 20130905113807) do

  create_table "a2_access_tokens", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "provider"
    t.string    "token"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
    t.string    "rails_env"
  end

  create_table "a2_assetables", :force => true do |t|
    t.integer   "asset_id"
    t.integer   "assetable_id"
    t.string    "assetable_type"
    t.timestamp "created_at",     :limit => 6, :null => false
    t.timestamp "updated_at",     :limit => 6, :null => false
  end

  create_table "a2_brands", :id => false, :force => true do |t|
    t.string    "id"
    t.string    "name"
    t.string    "domains"
    t.text      "description"
    t.timestamp "created_at",  :limit => 6, :null => false
    t.timestamp "updated_at",  :limit => 6, :null => false
  end

  create_table "a2_categories", :id => false, :force => true do |t|
    t.integer   "id",                         :null => false
    t.string    "name"
    t.string    "slug"
    t.text      "description"
    t.string    "img"
    t.integer   "position"
    t.boolean   "visible"
    t.string    "ancestry"
    t.timestamp "created_at",    :limit => 6, :null => false
    t.timestamp "updated_at",    :limit => 6, :null => false
    t.string    "type"
    t.string    "brand"
    t.integer   "magento_id"
    t.string    "filters"
    t.string    "name_singular"
    t.string    "long_name"
  end

  create_table "a2_colorables", :id => false, :force => true do |t|
    t.integer   "id",                          :null => false
    t.string    "color_code"
    t.string    "colorable_type"
    t.string    "colorable_id"
    t.integer   "position"
    t.timestamp "created_at",     :limit => 6, :null => false
    t.timestamp "updated_at",     :limit => 6, :null => false
  end

  create_table "a2_colors", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "name"
    t.string    "code"
    t.string    "brand"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_countries", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "name"
    t.string    "iso_code"
    t.string    "currency"
    t.string    "store_url"
    t.string    "locale"
    t.integer   "region_id"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_country_code_continents", :force => true do |t|
    t.string "country_code"
    t.string "continent_code"
  end

  add_index "a2_country_code_continents", ["country_code"], :name => "index_a2_country_code_continents_on_country_code", :unique => true

  create_table "a2_delayed_jobs", :id => false, :force => true do |t|
    t.integer   "id",                                     :null => false
    t.integer   "priority",                :default => 0
    t.integer   "attempts",                :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at",     :limit => 6
    t.timestamp "locked_at",  :limit => 6
    t.timestamp "failed_at",  :limit => 6
    t.string    "locked_by"
    t.string    "queue"
    t.timestamp "created_at", :limit => 6,                :null => false
    t.timestamp "updated_at", :limit => 6,                :null => false
  end

  create_table "a2_feeds", :id => false, :force => true do |t|
    t.integer   "id",                            :null => false
    t.string    "source"
    t.string    "type"
    t.timestamp "date",             :limit => 6
    t.string    "item_id"
    t.string    "tags"
    t.string    "url"
    t.text      "json"
    t.string    "image_url"
    t.timestamp "created_at",       :limit => 6, :null => false
    t.timestamp "updated_at",       :limit => 6, :null => false
    t.text      "title"
    t.string    "account_username"
    t.string    "account_id"
    t.string    "img"
  end

  create_table "a2_genders", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "gender"
    t.string    "slug"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_job_types", :id => false, :force => true do |t|
    t.integer   "id",                           :null => false
    t.string    "name"
    t.string    "parameters"
    t.string    "class_name"
    t.string    "method_name"
    t.boolean   "notify_by_email"
    t.timestamp "created_at",      :limit => 6, :null => false
    t.timestamp "updated_at",      :limit => 6, :null => false
  end

  create_table "a2_jobs", :id => false, :force => true do |t|
    t.integer   "id",                           :null => false
    t.integer   "job_type_id"
    t.string    "job_file"
    t.boolean   "notifi_by_email"
    t.timestamp "created_at",      :limit => 6, :null => false
    t.timestamp "updated_at",      :limit => 6, :null => false
    t.string    "parameters"
  end

  create_table "a2_news_letter_subscribers", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "email"
    t.string    "country"
    t.string    "city"
    t.string    "ip_address"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_online_stores", :id => false, :force => true do |t|
    t.integer   "id",                       :null => false
    t.string    "name"
    t.string    "img"
    t.string    "url"
    t.integer   "category_id"
    t.boolean   "visible"
    t.integer   "position"
    t.timestamp "created_at",  :limit => 6, :null => false
    t.timestamp "updated_at",  :limit => 6, :null => false
  end

  create_table "a2_page_translations", :id => false, :force => true do |t|
    t.integer   "id",                         :null => false
    t.integer   "a2_page_id"
    t.string    "locale"
    t.string    "title"
    t.string    "title_browser"
    t.string    "slug"
    t.text      "description"
    t.timestamp "created_at",    :limit => 6, :null => false
    t.timestamp "updated_at",    :limit => 6, :null => false
    t.text      "html"
  end

  create_table "a2_pages", :id => false, :force => true do |t|
    t.integer   "id",                         :null => false
    t.string    "img"
    t.string    "pid"
    t.integer   "category_id"
    t.string    "layout"
    t.timestamp "created_at",    :limit => 6, :null => false
    t.timestamp "updated_at",    :limit => 6, :null => false
    t.text      "html"
    t.string    "title"
    t.string    "title_browser"
    t.string    "slug"
    t.text      "description"
    t.string    "salomon_url"
  end

  create_table "a2_prices", :id => false, :force => true do |t|
    t.integer   "id",                                                            :null => false
    t.decimal   "price",                           :precision => 8, :scale => 2
    t.string    "product_variant_id"
    t.integer   "country_id"
    t.timestamp "created_at",         :limit => 6,                               :null => false
    t.timestamp "updated_at",         :limit => 6,                               :null => false
  end

  create_table "a2_product_assets", :force => true do |t|
    t.integer   "asset_id"
    t.integer   "product_id"
    t.string    "type"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_product_color_variants", :id => false, :force => true do |t|
    t.integer   "id",                        :null => false
    t.string    "sap"
    t.string    "color_1_code"
    t.string    "color_1_name"
    t.string    "model"
    t.boolean   "has_photos"
    t.timestamp "created_at",   :limit => 6, :null => false
    t.timestamp "updated_at",   :limit => 6, :null => false
    t.integer   "article_code"
    t.string    "brand"
  end

  create_table "a2_product_families", :id => false, :force => true do |t|
    t.integer   "id",                               :null => false
    t.string    "product_family_code"
    t.string    "product_family_name"
    t.timestamp "created_at",          :limit => 6, :null => false
    t.timestamp "updated_at",          :limit => 6, :null => false
    t.string    "brand"
  end

  create_table "a2_product_feature_types", :id => false, :force => true do |t|
    t.integer   "id",                                     :null => false
    t.integer   "feature_type_code"
    t.string    "name"
    t.timestamp "created_at",                :limit => 6, :null => false
    t.timestamp "updated_at",                :limit => 6, :null => false
    t.string    "brand"
    t.integer   "position"
    t.string    "category"
    t.boolean   "show_in_category_overview"
  end

  create_table "a2_product_features", :id => false, :force => true do |t|
    t.integer   "id",                                   :null => false
    t.integer   "feature_code"
    t.integer   "feature_type_code"
    t.string    "name"
    t.text      "description"
    t.timestamp "created_at",              :limit => 6, :null => false
    t.timestamp "updated_at",              :limit => 6, :null => false
    t.string    "brand"
    t.integer   "product_feature_type_id"
    t.integer   "position"
  end

  create_table "a2_product_images", :id => false, :force => true do |t|
    t.integer   "id",                        :null => false
    t.string    "sap"
    t.string    "size_code"
    t.string    "s3_key"
    t.string    "img"
    t.integer   "position"
    t.timestamp "created_at",   :limit => 6, :null => false
    t.timestamp "updated_at",   :limit => 6, :null => false
    t.string    "brand"
    t.integer   "variant_code"
  end

  create_table "a2_product_lines", :id => false, :force => true do |t|
    t.integer   "id",                             :null => false
    t.string    "product_line_code"
    t.string    "product_line_name"
    t.timestamp "created_at",        :limit => 6, :null => false
    t.timestamp "updated_at",        :limit => 6, :null => false
    t.string    "brand"
    t.string    "slug"
    t.string    "name"
  end

  create_table "a2_product_product_categories", :id => false, :force => true do |t|
    t.integer   "id",                               :null => false
    t.integer   "product_id"
    t.integer   "category_id"
    t.integer   "product_category_id"
    t.integer   "position"
    t.timestamp "created_at",          :limit => 6, :null => false
    t.timestamp "updated_at",          :limit => 6, :null => false
    t.string    "product_model"
  end

  create_table "a2_product_product_features", :id => false, :force => true do |t|
    t.integer   "id",                        :null => false
    t.integer   "prolog_code"
    t.integer   "feature_code"
    t.timestamp "created_at",   :limit => 6, :null => false
    t.timestamp "updated_at",   :limit => 6, :null => false
  end

  create_table "a2_product_translations", :id => false, :force => true do |t|
    t.integer   "id",                                                       :null => false
    t.integer   "a2_product_id"
    t.string    "locale"
    t.text      "description"
    t.string    "tag_line"
    t.timestamp "created_at",    :limit => 6,                               :null => false
    t.timestamp "updated_at",    :limit => 6,                               :null => false
    t.decimal   "price",                      :precision => 8, :scale => 2
  end

  create_table "a2_product_types", :id => false, :force => true do |t|
    t.integer   "id",                             :null => false
    t.string    "product_type_name"
    t.integer   "product_type_code"
    t.timestamp "created_at",        :limit => 6, :null => false
    t.timestamp "updated_at",        :limit => 6, :null => false
    t.string    "brand"
  end

  create_table "a2_product_variants", :id => false, :force => true do |t|
    t.integer   "id",                               :null => false
    t.string    "name"
    t.string    "model"
    t.integer   "article_code"
    t.string    "sap"
    t.string    "size_code"
    t.string    "color_1_code"
    t.string    "color_1_name"
    t.string    "size"
    t.string    "ean"
    t.timestamp "created_at",          :limit => 6, :null => false
    t.timestamp "updated_at",          :limit => 6, :null => false
    t.string    "brand"
    t.string    "gender"
    t.string    "product_family_code"
    t.string    "product_line_code"
    t.string    "season"
    t.integer   "technical_size"
    t.string    "description"
    t.string    "short_description"
    t.integer   "price_eu"
    t.integer   "price_us"
    t.string    "sourcing_country"
    t.integer   "weight"
    t.string    "dimensions"
    t.integer   "shopify_id"
    t.integer   "product_image_id"
  end

  create_table "a2_products", :force => true do |t|
    t.string    "model"
    t.string    "brand"
    t.string    "name"
    t.integer   "master_article_code"
    t.text      "description"
    t.integer   "product_type_code"
    t.timestamp "created_at",          :limit => 6, :null => false
    t.timestamp "updated_at",          :limit => 6, :null => false
    t.string    "product_line_code"
    t.string    "gender"
    t.integer   "article_code"
    t.string    "tag_line"
    t.integer   "prolog_code"
    t.string    "product_family_code"
    t.string    "season"
    t.string    "slug"
    t.integer   "shopify_id"
    t.boolean   "hidden"
    t.integer   "position"
  end

  add_index "a2_products", ["article_code"], :name => "index_a2_products_on_article_code", :unique => true
  add_index "a2_products", ["model"], :name => "index_a2_products_on_model", :unique => true
  add_index "a2_products", ["slug"], :name => "index_a2_products_on_slug", :unique => true

  create_table "a2_regions", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "name"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
    t.boolean   "visible"
  end

  create_table "a2_related_products", :id => false, :force => true do |t|
    t.integer   "id",                              :null => false
    t.integer   "product_id"
    t.integer   "related_product_id"
    t.timestamp "created_at",         :limit => 6, :null => false
    t.timestamp "updated_at",         :limit => 6, :null => false
  end

  create_table "a2_shops", :id => false, :force => true do |t|
    t.integer   "id",                       :null => false
    t.string    "name"
    t.string    "domain"
    t.string    "credentials"
    t.timestamp "created_at",  :limit => 6, :null => false
    t.timestamp "updated_at",  :limit => 6, :null => false
    t.string    "brand"
  end

  create_table "a2_team_member_products", :id => false, :force => true do |t|
    t.integer   "id",                          :null => false
    t.integer   "team_member_id"
    t.integer   "product_id"
    t.integer   "position"
    t.timestamp "created_at",     :limit => 6, :null => false
    t.timestamp "updated_at",     :limit => 6, :null => false
  end

  create_table "a2_team_members", :id => false, :force => true do |t|
    t.integer   "id",                                              :null => false
    t.string    "name"
    t.string    "slug"
    t.string    "fullname"
    t.text      "description"
    t.string    "country"
    t.string    "city"
    t.string    "vimeo"
    t.integer   "team_category_id"
    t.string    "tag_line"
    t.string    "video"
    t.string    "facebook"
    t.string    "twitter"
    t.string    "website"
    t.string    "instragram"
    t.string    "thumb_image"
    t.string    "main_image"
    t.string    "gender"
    t.boolean   "visible",                       :default => true
    t.timestamp "created_at",       :limit => 6,                   :null => false
    t.timestamp "updated_at",       :limit => 6,                   :null => false
    t.string    "quoter_name"
    t.string    "quoter_title"
  end

  create_table "a2_tech_definitions", :id => false, :force => true do |t|
    t.integer   "id",                                  :null => false
    t.string    "name"
    t.integer   "position"
    t.integer   "prolouge_techdefnu"
    t.boolean   "show_in_porduct_detail"
    t.timestamp "created_at",             :limit => 6, :null => false
    t.timestamp "updated_at",             :limit => 6, :null => false
  end

  create_table "a2_tech_feature_translations", :id => false, :force => true do |t|
    t.integer   "id",                              :null => false
    t.integer   "a2_tech_feature_id"
    t.string    "locale"
    t.string    "description"
    t.string    "image"
    t.timestamp "created_at",         :limit => 6, :null => false
    t.timestamp "updated_at",         :limit => 6, :null => false
  end

  create_table "a2_tech_features", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.string    "name"
    t.string    "logo"
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "a2_tech_specifications", :id => false, :force => true do |t|
    t.integer   "id",                                        :null => false
    t.integer   "prolouge_tech_definitaion_id"
    t.integer   "product_variant_id"
    t.integer   "tech_definition_id"
    t.string    "value"
    t.string    "unit"
    t.timestamp "created_at",                   :limit => 6, :null => false
    t.timestamp "updated_at",                   :limit => 6, :null => false
  end

  create_table "a2_user_translations", :id => false, :force => true do |t|
    t.integer   "id",                       :null => false
    t.integer   "a2_user_id"
    t.string    "locale"
    t.string    "description"
    t.timestamp "created_at",  :limit => 6, :null => false
    t.timestamp "updated_at",  :limit => 6, :null => false
  end

  create_table "a2_users", :id => false, :force => true do |t|
    t.integer   "id",                                                  :null => false
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",                  :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at", :limit => 6
    t.timestamp "remember_created_at",    :limit => 6
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at",     :limit => 6
    t.timestamp "last_sign_in_at",        :limit => 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",             :limit => 6,                 :null => false
    t.timestamp "updated_at",             :limit => 6,                 :null => false
    t.string    "picture"
  end

  create_table "rails_admin_histories", :id => false, :force => true do |t|
    t.integer   "id",                      :null => false
    t.text      "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year",       :limit => 8
    t.timestamp "created_at", :limit => 6, :null => false
    t.timestamp "updated_at", :limit => 6, :null => false
  end

  create_table "taggings", :id => false, :force => true do |t|
    t.integer   "id",                           :null => false
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context",       :limit => 128
    t.timestamp "created_at",    :limit => 6
  end

  create_table "tags", :id => false, :force => true do |t|
    t.integer "id",       :null => false
    t.string  "name"
    t.string  "tag_type"
    t.string  "ancestry"
    t.integer "position"
  end

end
