SalomonWww::Application.routes.draw do

  get "video/index"

  namespace :admin do
    get "category/assign_product_to_category"
  end


  #scope :path => "(:locale)", :shallow_path => "(:locale)", :locale => /en-US|de-CH|de-DE|en-UK|fr-CH|fr-FR|ru-RU/ do
  localized do
    match '/' => 'home#index', :as => 'home'
    match 'contact' => 'home#contact', :as => 'contact'
    match 'terms' => 'home#terms', :as => 'terms'
    match 'privacy_policy' => 'home#privacy_policy', :as => 'privacy_policy'
    match 'warranty' => 'home#warranty', :as => 'warranty'
    match 'stores' => 'store#index', :as => 'store'
    match 'videos' => 'video#index', :as => 'video'
    match 'team' => 'team#index', :as => 'team'
    match 'team/rider-:team_member' => 'team#show', :as => 'team_member'
    match 'team(/:category)' => 'team#index', :as => 'team'
    match 'gear/(:category)' => 'product#index', :as => 'products'
    match 'gear/(:category)/(:product)' => 'product#show', :as => 'product_show'
  end



  mount A2::Engine => "/a2"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
