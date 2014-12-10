Rails.application.routes.draw do
  resources :articles

  devise_for :users
  mount Commontator::Engine => '/commontator'

  resources :servers
  resources :profiles, as: :profile
  resource :payments
  resource :contact
  resource :feeds
  resource :search, :controller => 'search'
  get 'my_servers' => 'servers#my_servers'

  # Example resource route within a namespace:
    namespace :admin do
      resources :categories
      resources :settings
      resources :servers
      resources :users
      resources :comments
      resources :payments
    end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'servers#index'

  # Example of regular route:
    post 'servers/check'      => 'servers#check'
    get 'servers/:id/banner' => 'servers#banner'
    post 'servers/:id/vote'  => 'servers#vote', as: :vote
    post 'payments/callback' => 'payments#callback', as: :callback

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

end
