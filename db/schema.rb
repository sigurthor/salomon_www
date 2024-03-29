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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140909090945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "a2_access_tokens", force: true do |t|
    t.string   "provider"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "rails_env"
  end

  add_index "a2_access_tokens", ["provider", "rails_env"], name: "index_a2_access_tokens_on_provider_and_rails_env", unique: true, using: :btree

  create_table "a2_assetables", force: true do |t|
    t.integer  "asset_id"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "a2_assets", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "img"
    t.string   "video_id"
    t.string   "video_url"
    t.string   "video_image_url"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "a2_banners", force: true do |t|
    t.string   "pid"
    t.string   "title"
    t.string   "subtitle"
    t.string   "image"
    t.string   "video"
    t.string   "link_url"
    t.string   "link_text"
    t.text     "content"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "a2_box_shares", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "expire"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "box_embed_url"
  end

  create_table "a2_brands", id: false, force: true do |t|
    t.string   "id"
    t.string   "name"
    t.string   "domains"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "a2_categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "img"
    t.integer  "position"
    t.boolean  "visible"
    t.string   "ancestry"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "type"
    t.string   "brand"
    t.integer  "magento_id"
    t.string   "filters"
    t.string   "name_singular"
    t.string   "long_name"
    t.integer  "ancestry_depth",     default: 0
    t.string   "title"
    t.string   "google_url"
    t.boolean  "show_in_stock_only"
    t.string   "show_season"
  end

  add_index "a2_categories", ["ancestry"], name: "index_a2_categories_on_ancestry", using: :btree
  add_index "a2_categories", ["slug"], name: "index_a2_categories_on_slug", using: :btree

  create_table "a2_colorables", force: true do |t|
    t.string   "color_code"
    t.string   "colorable_type"
    t.integer  "colorable_id"
    t.integer  "position"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "a2_colorables", ["color_code", "colorable_id", "colorable_type"], name: "code_id_type", unique: true, using: :btree

  create_table "a2_colors", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "brand"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "value",      default: "ffffff"
  end

  add_index "a2_colors", ["code", "brand"], name: "brand_colors", unique: true, using: :btree

  create_table "a2_countries", force: true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.string   "currency"
    t.string   "store_url"
    t.string   "locale"
    t.integer  "region_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "salomon_locale"
  end

  create_table "a2_country_code_continents", force: true do |t|
    t.string "country_code"
    t.string "continent_code"
  end

  add_index "a2_country_code_continents", ["country_code"], name: "index_a2_country_code_continents_on_country_code", unique: true, using: :btree

  create_table "a2_feeds", force: true do |t|
    t.string   "source"
    t.string   "type"
    t.datetime "date"
    t.string   "item_id"
    t.string   "tags"
    t.string   "url"
    t.text     "json"
    t.string   "image_url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "title"
    t.string   "account_username"
    t.string   "account_id"
    t.string   "img"
  end

  create_table "a2_genders", force: true do |t|
    t.string   "gender"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "a2_genders", ["gender", "slug"], name: "index_a2_genders_on_gender_and_slug", unique: true, using: :btree

  create_table "a2_job_types", force: true do |t|
    t.string   "name"
    t.string   "parameters"
    t.string   "class_name"
    t.string   "method_name"
    t.boolean  "notify_by_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "a2_jobs", force: true do |t|
    t.integer  "job_type_id"
    t.string   "job_file"
    t.boolean  "notifi_by_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "parameters"
    t.string   "name"
    t.string   "trigger"
    t.boolean  "run_now"
  end

  create_table "a2_lookbooks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "img"
    t.string   "slug"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "a2_news_letter_subscribers", force: true do |t|
    t.string   "email"
    t.string   "country"
    t.string   "city"
    t.string   "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a2_online_stores", force: true do |t|
    t.string   "name"
    t.string   "img"
    t.string   "url"
    t.integer  "category_id"
    t.boolean  "visible"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "a2_page_translations", force: true do |t|
    t.integer  "a2_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "title_browser"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "html"
  end

  add_index "a2_page_translations", ["a2_page_id"], name: "index_a2_page_translations_on_a2_page_id", using: :btree
  add_index "a2_page_translations", ["locale"], name: "index_a2_page_translations_on_locale", using: :btree

  create_table "a2_pages", force: true do |t|
    t.string   "img"
    t.string   "pid"
    t.integer  "category_id"
    t.string   "layout"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "html"
    t.string   "title"
    t.string   "title_browser"
    t.string   "slug"
    t.text     "description"
    t.string   "salomon_url"
  end

  add_index "a2_pages", ["pid"], name: "index_a2_pages_on_pid", unique: true, using: :btree

  create_table "a2_prices", force: true do |t|
    t.decimal  "price",              precision: 8, scale: 2
    t.string   "product_variant_id"
    t.integer  "country_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "a2_prices", ["product_variant_id", "country_id"], name: "product_price", unique: true, using: :btree

  create_table "a2_product_assets", force: true do |t|
    t.integer  "asset_id"
    t.integer  "product_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a2_product_color_variants", force: true do |t|
    t.string   "sap"
    t.string   "color_1_code"
    t.string   "color_1_name"
    t.string   "model"
    t.boolean  "has_photos"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "article_code"
    t.string   "brand"
    t.integer  "position"
    t.integer  "product_images_count"
    t.string   "season"
  end

  add_index "a2_product_color_variants", ["model"], name: "index_a2_product_color_variants_on_model", using: :btree
  add_index "a2_product_color_variants", ["sap"], name: "index_a2_product_color_variants_on_sap", unique: true, using: :btree

  create_table "a2_product_families", force: true do |t|
    t.string   "product_family_code"
    t.string   "product_family_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "brand"
  end

  add_index "a2_product_families", ["product_family_code"], name: "index_a2_product_families_on_product_family_code", unique: true, using: :btree

  create_table "a2_product_feature_types", force: true do |t|
    t.integer  "feature_type_code"
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "brand"
    t.integer  "position"
    t.string   "category"
    t.boolean  "show_in_category_overview"
  end

  add_index "a2_product_feature_types", ["feature_type_code"], name: "index_a2_product_feature_types_on_feature_type_code", unique: true, using: :btree

  create_table "a2_product_features", force: true do |t|
    t.integer  "feature_code"
    t.integer  "feature_type_code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "brand"
    t.integer  "product_feature_type_id"
    t.integer  "position"
  end

  add_index "a2_product_features", ["feature_code"], name: "index_a2_product_features_on_feature_code", unique: true, using: :btree

  create_table "a2_product_images", force: true do |t|
    t.string   "sap"
    t.string   "size_code"
    t.string   "s3_key"
    t.string   "img"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "brand"
    t.integer  "variant_code"
    t.integer  "spree_id"
  end

  add_index "a2_product_images", ["sap"], name: "index_a2_product_images_on_sap", using: :btree

  create_table "a2_product_lines", force: true do |t|
    t.string   "product_line_code"
    t.string   "product_line_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "brand"
    t.string   "slug"
    t.string   "name"
  end

  add_index "a2_product_lines", ["product_line_code"], name: "index_a2_product_lines_on_product_line_code", unique: true, using: :btree

  create_table "a2_product_product_categories", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.integer  "product_category_id"
    t.integer  "position"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "product_model"
  end

  add_index "a2_product_product_categories", ["product_category_id", "product_id"], name: "product_category", unique: true, using: :btree

  create_table "a2_product_product_features", force: true do |t|
    t.integer  "prolog_code"
    t.integer  "feature_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "a2_product_product_features", ["prolog_code", "feature_code"], name: "prolog_code_feature_code", unique: true, using: :btree

  create_table "a2_product_translations", force: true do |t|
    t.integer  "a2_product_id"
    t.string   "locale"
    t.text     "description"
    t.string   "tag_line"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "price",         precision: 8, scale: 2
  end

  add_index "a2_product_translations", ["a2_product_id"], name: "index_a2_product_translations_on_a2_product_id", using: :btree
  add_index "a2_product_translations", ["locale"], name: "index_a2_product_translations_on_locale", using: :btree

  create_table "a2_product_types", force: true do |t|
    t.string   "product_type_name"
    t.integer  "product_type_code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "brand"
  end

  add_index "a2_product_types", ["product_type_code"], name: "index_a2_product_types_on_code", unique: true, using: :btree

  create_table "a2_product_variants", force: true do |t|
    t.string   "name"
    t.string   "model"
    t.integer  "article_code"
    t.string   "sap"
    t.string   "size_code"
    t.string   "color_1_code"
    t.string   "color_1_name"
    t.string   "size"
    t.string   "ean"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "brand"
    t.string   "gender"
    t.string   "product_family_code"
    t.string   "product_line_code"
    t.string   "season"
    t.string   "technical_size"
    t.string   "description"
    t.string   "short_description"
    t.integer  "price_eu"
    t.integer  "price_us"
    t.string   "sourcing_country"
    t.float    "weight"
    t.string   "dimensions"
    t.integer  "spree_id"
    t.integer  "product_image_id"
  end

  add_index "a2_product_variants", ["article_code"], name: "index_a2_product_variants_on_article_code", using: :btree
  add_index "a2_product_variants", ["size_code"], name: "index_a2_product_variants_on_size_code", unique: true, using: :btree

  create_table "a2_products", force: true do |t|
    t.string   "model"
    t.string   "brand"
    t.string   "name"
    t.integer  "master_article_code"
    t.text     "description"
    t.integer  "product_type_code"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "product_line_code"
    t.string   "gender"
    t.integer  "article_code"
    t.string   "tag_line"
    t.integer  "prolog_code"
    t.string   "product_family_code"
    t.string   "season"
    t.string   "slug"
    t.integer  "spree_id"
    t.boolean  "hidden"
    t.integer  "position"
    t.string   "name2"
    t.string   "project_code"
    t.decimal  "cost",                precision: 8, scale: 2
    t.string   "google_url"
    t.text     "seasons",                                     default: [],              array: true
  end

  add_index "a2_products", ["article_code"], name: "index_a2_products_on_article_code", unique: true, using: :btree
  add_index "a2_products", ["model"], name: "index_a2_products_on_model", unique: true, using: :btree
  add_index "a2_products", ["seasons"], name: "index_a2_products_on_seasons", using: :gin
  add_index "a2_products", ["slug"], name: "index_a2_products_on_slug", unique: true, using: :btree

  create_table "a2_regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "visible"
  end

  create_table "a2_related_products", force: true do |t|
    t.integer  "product_id"
    t.integer  "related_product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "a2_related_products", ["product_id", "related_product_id"], name: "product_related", unique: true, using: :btree

  create_table "a2_retailers", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "address"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.string   "phone"
    t.string   "postal_code"
    t.boolean  "hidden"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "a2_shops", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "credentials"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "brand"
  end

  create_table "a2_team_member_products", force: true do |t|
    t.integer  "team_member_id"
    t.integer  "product_id"
    t.integer  "position"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "a2_team_member_products", ["team_member_id", "product_id"], name: "team_member_product", unique: true, using: :btree

  create_table "a2_team_members", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "fullname"
    t.text     "description"
    t.string   "country"
    t.string   "city"
    t.string   "vimeo"
    t.integer  "team_category_id"
    t.string   "tag_line"
    t.string   "video"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "website"
    t.string   "instragram"
    t.string   "thumb_image"
    t.string   "main_image"
    t.string   "gender"
    t.boolean  "visible",          default: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "quoter_name"
    t.string   "quoter_title"
    t.string   "instagram"
    t.string   "sports"
  end

  create_table "a2_tech_definitions", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "prolouge_techdefnu"
    t.boolean  "show_in_porduct_detail"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "a2_tech_definitions", ["prolouge_techdefnu"], name: "index_a2_tech_definitions_on_prolouge_techdefnu", unique: true, using: :btree

  create_table "a2_tech_feature_translations", force: true do |t|
    t.integer  "a2_tech_feature_id"
    t.string   "locale"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "a2_tech_feature_translations", ["a2_tech_feature_id"], name: "index_a2_tech_feature_translations_on_a2_tech_feature_id", using: :btree
  add_index "a2_tech_feature_translations", ["locale"], name: "index_a2_tech_feature_translations_on_locale", using: :btree

  create_table "a2_tech_features", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "a2_tech_specifications", force: true do |t|
    t.integer  "prolouge_tech_definitaion_id"
    t.integer  "product_variant_id"
    t.integer  "tech_definition_id"
    t.string   "value"
    t.string   "unit"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "a2_tech_specifications", ["product_variant_id", "tech_definition_id"], name: "product_tech_def", unique: true, using: :btree

  create_table "a2_user_translations", force: true do |t|
    t.integer  "a2_user_id"
    t.string   "locale"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "a2_user_translations", ["a2_user_id"], name: "index_a2_user_translations_on_a2_user_id", using: :btree
  add_index "a2_user_translations", ["locale"], name: "index_a2_user_translations_on_locale", using: :btree

  create_table "a2_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "picture"
  end

  add_index "a2_users", ["email"], name: "index_a2_users_on_email", unique: true, using: :btree
  add_index "a2_users", ["reset_password_token"], name: "index_a2_users_on_reset_password_token", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       limit: 8
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "taggable_id_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.string  "tag_type"
    t.string  "ancestry"
    t.integer "position"
  end

  add_index "tags", ["ancestry"], name: "index_tags_on_ancestry", using: :btree

end
