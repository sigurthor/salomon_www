  require Rails.root.join("config/environments/development")
  puts "frontend development"
  SalomonWww::Application.configure do

    config.cache_store = :dalli_store
    config.active_record.auto_explain_threshold_in_seconds = nil
    config.assets.debug = false
    config.action_controller.perform_caching = true
  end
