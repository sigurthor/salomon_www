require 'heroku-api'

unless Rails.env.development? || Rails.env.frontend_development?
  heroku = Heroku::API.new(:api_key => Rails.application.config.heroku_api)
  release_version = heroku.get_releases(ENV['APP_NAME']).body.last
  ENV["ETAG_VERSION_ID"] = release_version["name"]
end
