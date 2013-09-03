require Rails.root.join("config/environments/production")
puts "staging enviorment"
SalomonWww::Application.configure do

  #webshop url
  config.webshop_url = 'http://dev.shop.salomon.com/'

  #instagram
  config.instagram_client_id = "35c4114674ef40ac8fbb05c5b5c8a4ad"
  config.instagram_client_secret = "affc75a216e44cfcae33eb202a932ea7"

  #faceboook
  config.facebook_callback_url = 'http://salomon-dev.herokuapp.com/a2/auth/facebook/callback/'
  config.facebook_app_id = "505158699573060"
  config.facebook_app_secret = "d855b3d938519bb8c5fc0f62594b5120"

end
