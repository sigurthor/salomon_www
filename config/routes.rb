SalomonWww::Application.routes.draw do

  match '/404', :to => 'error#not_found'

  get "video/index"

  namespace :admin do
    get "category/assign_product_to_category"
  end



  #scope :path => "(:locale)", :shallow_path => "(:locale)", :locale => /en-US|de-CH|de-DE|en-UK|fr-CH|fr-FR|ru-RU/ do
  localized do
    match '/' => 'home#index', :as => 'home'
    match 'faq' => 'home#faq', :as => 'faq'
    match 'contact/ok' => 'home#contact_ok', :as => 'contact_ok'
    match 'contact' => 'home#contact', :as => 'contact'
    match 'terms' => 'home#terms', :as => 'terms'
    match 'privacy_policy' => 'home#privacy_policy', :as => 'privacy_policy'
    match 'warranty' => 'home#warranty', :as => 'warranty'
    match 'stores' => 'store#index', :as => 'store'
    match 'videos' => 'video#index', :as => 'video'
    match 'team' => 'team#index', :as => 'team'
    match 'team/rider-(:team_member)' => 'team#show', :as => 'team_member'
    match 'team(/:category)' => 'team#index', :as => 'team'
    match 'gear/(:category)' => 'product#index', :as => 'products'
    match 'gear/(:category)/(:product)' => 'product#show', :as => 'product_show'
  end

  # legacy redirects
  #Redirects
  match 'salomon-gear.html' => redirect('/')
  match 'teams' => redirect('/team')
  match 'dealers' => redirect('/')
  match '/catalog/product/view/id/:id/s/(:slug)-(:variant)/category/(:cat)' => 'product#legacy'



  root :to => 'home#index'

end
