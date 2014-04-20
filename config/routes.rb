Sebastes::Application.routes.draw do
  devise_for :provide_users, controllers: { sessions: 'provide/sessions' }
  devise_for :admin_users, controllers: { sessions: 'admin/sessions' }
  devise_for :users

  scope 'users' do
    get 'destination' => 'users#destination_edit', as: 'edit_user_destination'
    patch 'destination' => 'users#destination_update', as: 'user_destination'
  end

  resource :coupons, only: [:update] do
    member do
      get 'find'
    end
  end
  resources :orders, except: [:edit, :update]
  resources :user_point_logs, only: [:index]
  resources :items, only: [:index]
  resources :diaries do
    member do
      get 'good'
    end
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  scope 'cart' do
    resource :cart_item, only: [:create, :update, :destroy], path: 'items/:item_id' do
      member do
        get 'add'
      end
    end
    resources :cart_items, only: [:index], path: 'items'
  end

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
