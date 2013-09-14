SalomonWww::Application.configure do

  config.eager_load = true

  #asset host
  config.action_controller.asset_host = ENV['ASSET_HOST']

  #webshop url
  config.webshop_url = 'http://shop.salomon.com/'
  config.salomon_url = 'http://www.salomon.com/'

  #instagram
  config.instagram_callback_url =  'http://salomon-prod.herokuapp.com/a2/auth/instagram/callback'
  config.instagram_client_id = 'cdb7302983ec4cce94d189806f9454d2'
  config.instagram_client_secret = '6db1e69934f74db2a01ea750608c5da5'

  #faceboook
  config.facebook_callback_url = 'http://salomon-prod.herokuapp.com/a2/auth/facebook/callback/'
  config.facebook_app_id = '505158699573060'
  config.facebook_app_secret = 'd855b3d938519bb8c5fc0f62594b5120'

  #cashier
  config.cashier.adapter = :cache_store

  #heroku api key
  config.heroku_api = '5df2c849bb04d21744311d6d4940455b3cd1ff50'

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  config.static_cache_control = "public, max-age=31536000"

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true



  # Use a different cache store in production
  config.cache_store = :dalli_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)

  config.assets.precompile += %w( application_head.js html5shiv.js respond.min.js rails_admin/rails_admin_nestable.js rails_admin/jquery.nestable.js rails_admin/rails_admin_nestable.css mustache.js)

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
end
