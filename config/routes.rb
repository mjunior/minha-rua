Rails.application.routes.draw do
  # resources :complaints
  get 'home/index'

  #resources :complaints
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  # get 'products/:id' => 'catalog#view'

  match 'home' => 'home#index', via: 'get'
  match 'inicio' => 'home#index', via: 'get'
  match 'cidade/search' => 'cidade#search', via: 'get'

  get 'complaints/' => 'complaints#index'
  get 'sign_out;' => 'devise/sessions#destroy'
  get '/:cidade/', to: 'cidade#show', as: 'cidades'
  get '/:cidade/reclamar', to: 'complaints#new', as: 'reclamar'

  resources :complaints , path_names: { new: 'criar' } do
     get 'liked' => 'complaints#liked' , on: :collection
     post 'like' => 'complaints#like'
  end

  #cria nova reclamação de abuso

  post 'complaints/abuse' => 'complaints#abuse'
  post 'complaints/reply' => 'complaints#reply'
  post 'email/contato' => 'home#contato' , :defaults => { :format => 'json' }

  devise_for :users, controllers: {registrations:"registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do
    get 'users/logout', :to => 'devise/sessions#destroy', :as => :logout_user
  end
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

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
