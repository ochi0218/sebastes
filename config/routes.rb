Sebastes::Application.routes.draw do
  get "user_point_logs/index"
  devise_for :provide_users, controllers: { sessions: 'provide/sessions' }
  devise_for :admin_users, controllers: { sessions: 'admin/sessions' }
  devise_for :users

  get 'users/destination/edit' => 'users#destination_edit', as: 'edit_users_distination'
  patch 'users/destination' => 'users#destination_update', as: 'users_distination'
  resources :diaries do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end
  get 'cart/items' => 'cart_items#index', as: 'cart_item_list'
  get 'cart/items/add/:item_id' => 'cart_items#add', as: 'add_cart_items'
  resource :cart_items, only: [:create, :update, :destroy], as: 'cart_items', path: 'cart/items/:item_id'
  get 'diaries/:id/good' => 'diaries#good', as: 'good_diary'
  get 'items' => 'items#index'

  namespace :admin do
    root 'items#index'
    resources :coupons
    resources :items
    resources :users do 
      resource :user_point_logs, only: [:new, :create]
    end
    resources :provide_users
  end

  namespace :provide do
    root 'items#index'
    resources :items, only: [:index, :show, :edit, :update]
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'diaries#index'

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
