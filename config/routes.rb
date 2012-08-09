Fc19::Application.routes.draw do

#  doesn't work
#  root :to => "builds#index"

  match  '/builds/fix/:id', :controller => 'builds', :action => 'fix', :as => :fix_build, :via => [:get]
  match  '/builds/clean/:id', :controller => 'builds', :action => 'clean', :as => :clean_build, :via => [:get]

  match  '/failures/fix/:id', :controller => 'failures', :action => 'fix', :as => :fix_failure, :via => [:get]
  match  '/failures/clean/:id', :controller => 'failures', :action => 'clean', :as => :clean_failure, :via => [:get]

  match  '/resolutions/fix/:id', :controller => 'resolutions', :action => 'fix', :as => :fix_resolution, :via => [:get]
  match  '/resolutions/clean/:id', :controller => 'resolutions', :action => 'clean', :as => :clean_resolution, :via => [:get]
  match  '/resolutions/linkto/:id', :controller => 'resolutions', :action => 'linkto', :as => :linkto_resolution, :via => [:get]
  match  '/resolutions/matchlist', :controller => 'resolutions', :action => 'matchlist', :as => :matchlist_resolution, :via => [:get]

  match  '/recentbuilds/showlist', :controller => 'recentbuilds', :action => 'showlist', :as => :recentbuilds_showlist, :via => [:get]
  match  '/recentbuilds/loadbuild', :controller => 'recentbuilds', :action => 'loadbuild', :as => :recentbuilds_loadbuild, :via => [:get]



  resources :failures

  resources :resolutions

  resources :builds
  resources :recentbuilds

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
