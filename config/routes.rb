SalomonWww::Application.routes.draw do

  get "video/index"

  namespace :admin do
    get "category/assign_product_to_category"
  end



  #scope :path => "(:locale)", :shallow_path => "(:locale)", :locale => /en-US|de-CH|de-DE|en-UK|fr-CH|fr-FR|ru-RU/ do
  localized do
    match '/' => 'home#index', :as => 'home'
    match 'faq' => 'home#faq', :as => 'faq'
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



  root :to => 'home#index'

end
