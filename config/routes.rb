  Rails.application.routes.draw do

  get 'home/index'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :admin do
    resources :users do
      member do
        put '/make_admin', to: 'users#make_admin'
        put '/unset_admin', to: 'users#unset_admin'
      end
    end
    resources :manage_challenges
    resources :manage_pages
    get '/', to: 'admin#index'
  end

  resources :challenges, only:[:index, :show]

  namespace :challenge do
    resources :registrations, only: [:create, :new] do
      collection do
        get '/confirmation', to: 'registrations#confirmation'

      end
    end
    get '/manage_entry/edit', to: 'manage_entry#edit'
    patch '/manage_entry/update', to: 'manage_entry#update'
  end

  #voting
  get '/voting', to: 'voting#show'
  post '/voting', to: 'voting#create'

  #static content
  resources :about, only: [:index, :show]


  # get '/register_for_challenge/:challenge_id', to:
# get '/patients/:id', to: 'patients#show'

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
  root to: "challenges#index"

end
