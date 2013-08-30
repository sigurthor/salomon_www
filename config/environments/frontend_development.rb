require Rails.root.join("config/environments/development")
puts "frontend development"
SalomonWww::Application.configure do
  #config.identity_cache_store = :mem_cache_store, Memcached::Rails.new(:servers => ["127.0.0.1"])
  #Expands the lines which load the assets
  config.cache_store = :dalli_store
  config.active_record.auto_explain_threshold_in_seconds = nil
  config.assets.debug = false
  config.action_controller.perform_caching = true
end
