App::Application.routes.draw do
  resources :posts

  resources :patients

  get "messages/index"
  match "user_token_input" => 'conversations#user_token_input'
  match "search_conversations_by_name" => 'conversations#search_conversations_by_name'
  match "reply_message/:id" => 'conversations#reply_message', :as => :reply_message

  devise_for :users
  resources :billing_entities
  resources :message_recipients do
    member do
      delete 'unread'
    end
  end
  resources :messages do
    collection do
      post 'search'
      get 'notifications'
      get 'autocomplete_user_email'
    end
  end

  resources :conversations do
    collection do
      get 'notifications'
    end
    member do
     get "mark_as_read"
     get "mark_as_unread"
     get "archive"
    end
  end

  get "pages/home"
  root :to => "pages#home"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
