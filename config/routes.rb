Tatekaeapp::Application.routes.draw do



  resources :fopt_masters


  root :to => 'events#index', via: :get
  
  match "events/:event_str_id/message" => 'message#new', via: :get, as: 'event_message'
  match "events/:event_str_id/message" => 'message#send_message', via: :post


  match 'admin/events' => 'admin#events_index' , via: :get
  match 'events/:str_id/paticipants' => 'paticipants#show_to_delete' , via: :get
  match 'events/:str_id/paticipants' => 'paticipants#delete_multiple' , via: :post
  match 'events/:str_id/paticipants' => 'paticipants#delete_multiple' , via: :post

  match 'events/:event_str_id/applicants' => 'forms#index' , via: :get, as: 'event_applicants' 
  match 'events/form/:form_str_id' => 'forms#show', via: :get, as: 'form'
  match 'events/:event_str_id/form' => 'forms#new' , via: :get, as: 'event_new_form'
  match 'events/:event_str_id/form' => 'forms#create', via: :post
  match 'events/form/:form_str_id/edit' => 'forms#edit', via: :get, as: 'edit_form'
  match 'events/form/:form_str_id/edit' => 'forms#update', via: :put
  match 'events/form/:form_str_id/' => 'forms#destroy', via: :delete, as: 'delete_form'

  resources :forms, except: ["show","edit","update","create","delete","new"]
  
  #match 'events/:str_id/edit' => 'events#edit',  as: 'edit_event',:via => :get
  #match 'events' => 'events#index',  as: 'events',:via => :get
  #match 'events' => 'events#create',  :via => :post

  resources :payments
  resources :paticipants
  resources :events
  match 'paticipants/create_plural/' => 'paticipants#create_plural', 
          as: 'create_plural_paticipants', via: :post
  match 'paticipants/create_plural_with_name/' => 'paticipants#create_plural_with_name' ,
          as: 'create_plural_paticipants_with_name', via: :post


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
