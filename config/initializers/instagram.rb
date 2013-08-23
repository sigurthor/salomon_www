require "instagram"

Instagram.configure do |config|

  config.client_id = Rails.application.config.instagram_client_id
  config.client_secret = Rails.application.config.instagram_client_secret
end