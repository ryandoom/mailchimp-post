MailchimpPost::Application.routes.draw do

  resources :logs, :except => [:new, :create, :edit, :update, :destroy]

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
#== Route Map
# Generated on 16 Jan 2015 16:40
#
#                                logs GET      /logs(.:format)                                logs#index
#                                 log GET      /logs/:id(.:format)                            logs#show
#                            cc_index GET      /cc(.:format)                                  cc#index
#                                     POST     /cc(.:format)                                  cc#create
#                              new_cc GET      /cc/new(.:format)                              cc#new
#                             edit_cc GET      /cc/:id/edit(.:format)                         cc#edit
#                                  cc PATCH    /cc/:id(.:format)                              cc#update
#                                     PUT      /cc/:id(.:format)                              cc#update
#                                     DELETE   /cc/:id(.:format)                              cc#destroy
#                        cc_subscribe GET|POST /cc/:id(.:format)                              cc#index
#                             cc_auth GET|POST /auth/cc(.:format)                             cc#auth
#                       cc_auth_start GET|POST /auth/cc/start(.:format)                       cc#auth_start
#                         cc_auth_end GET|POST /auth/cc/end(.:format)                         cc#auth_end
#                                data GET      /data(.:format)                                data#index
#                                     POST     /data(.:format)                                data#create
#                           new_datum GET      /data/new(.:format)                            data#new
#                          edit_datum GET      /data/:id/edit(.:format)                       data#edit
#                               datum GET      /data/:id(.:format)                            data#show
#                                     PATCH    /data/:id(.:format)                            data#update
#                                     PUT      /data/:id(.:format)                            data#update
#                                     DELETE   /data/:id(.:format)                            data#destroy
#                                     GET|POST /data/:id(.:format)                            data#index
#            mail_chimp_documentation GET      /mail_chimp_documentation(.:format)            data#mail_chimp_documentation
#      constant_contact_documentation GET      /constant_contact_documentation(.:format)      data#constant_contact_documentation
# google_event_tracking_documentation GET      /google_event_tracking_documentation(.:format) data#google_event_tracking_documentation
#                                root GET      /                                              data#index
