MailchimpPost::Application.routes.draw do

  resources :cc, :except => [:show]
  match "cc/:id" => "cc#index", :via => [:get,:post], :as => :cc_subscribe
  match "auth/cc" => "cc#auth", :via => [:get,:post], :as => :cc_auth
  match "auth/cc/start" => "cc#auth_start", :via => [:get,:post], :as => :cc_auth_start
  match "auth/cc/end" => "cc#auth_end", :via => [:get,:post], :as => :cc_auth_end

  resources :data
  match "data/:id" => "data#index", :via => [:get,:post]

  get "mail_chimp_documentation" => "data#mail_chimp_documentation", :as => :mail_chimp_documentation
  get "constant_contact_documentation" => "data#constant_contact_documentation", :as => :constant_contact_documentation
  get "google_event_tracking_documentation" => "data#google_event_tracking_documentation", :as => :google_event_tracking_documentation
  
  root "data#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
