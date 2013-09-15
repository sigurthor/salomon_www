require 'heroku-api'

if Rails.env.production? || Rails.env.staging?
  #heroku = Heroku::API.new(:api_key => Rails.application.config.heroku_api)
  #release_version = heroku.get_releases(ENV['APP_NAME']).body.last
  ENV["ETAG_VERSION_ID"] = '23' #release_version["name"]
end
