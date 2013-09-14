SalomonWww::Application.routes.draw do
  puts "drawing routes"

  get '/404', :to => 'error#not_found'

  get "video/index"

  namespace :admin do
    get "category/assign_product_to_category"
  end



  #scope :path => "(:locale)", :shallow_path => "(:locale)", :locale => /en-US|de-CH|de-DE|en-UK|fr-CH|fr-FR|ru-RU/ do
  localized do
    get '/' => 'home#index', :as => 'home'
    get 'faq' => 'home#faq', :as => 'faq'
    get 'contact/ok' => 'home#contact_ok', :as => 'contact_ok'
    get 'contact' => 'home#contact', :as => 'contact'
    get 'terms' => 'home#terms', :as => 'terms'
    get 'privacy_policy' => 'home#privacy_policy', :as => 'privacy_policy'
    get 'warranty' => 'home#warranty', :as => 'warranty'
    get 'stores' => 'store#index', :as => 'store'
    get 'videos' => 'video#index', :as => 'video'
    get 'team' => 'team#index', :as => 'team'
    get 'team/rider-(:team_member)' => 'team#show', :as => 'team_member'
    get 'team(/:category)' => 'team#index', :as => 'team'
    get 'gear/(:category)' => 'product#index', :as => 'products'
    get 'gear/(:category)/(:product)' => 'product#show', :as => 'product_show'
  end

  # legacy redirects
  #Redirects
  get 'salomon-gear.html' => redirect('/')
  get 'teams' => redirect('/team')
  get 'dealers' => redirect('/')
  get '/catalog/product/view/id/:id/s/(:slug)-(:variant)/category/(:cat)' => 'product#legacy'



  root :to => 'home#index'

end
