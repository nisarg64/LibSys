Rails.application.routes.draw do
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

  get 'suggestions/new'

  get 'suggestions/index'

  get 'admin/admin_list'

  get 'admin/index'

  get 'admin/destroy'

  get 'admin/edit'

  get 'admin/update'

  resources :admin

  get 'sessions/new'

  get 'library_members/index'
  get 'library_members/edit'
  get 'library_members/show'
  get 'library_members/update'

  get 'library_members/new'
  get 'library_members/home'

  get 'helper_pages/about'
  get 'helper_pages/contact'
  get 'helper_pages/home'
  post 'books/search' => 'books#search'
  get  'books/search' => 'books#index'

  root             'helper_pages#home'
  get 'about'   => 'helper_pages#about'
  get 'contact' => 'helper_pages#contact'
  get 'signup'  => 'library_members#new'

  get    'admin_login'   => 'sessions#new_admin'
  post   'admin_login'   => 'sessions#create_admin'

  get   'suggestion_new'   => 'suggestions#new'
  post  'suggestion_new'   => 'suggestions#create'
  get   'suggestion'   => 'suggestions#index'
  post  'suggestion'   => 'suggestions#index'


  get    'member_login'   => 'sessions#new_member'
  post   'member_login'   => 'sessions#create_member'
  delete 'logout'  => 'sessions#destroy'
  get 'suggestion/:id/destroy'  => 'suggestions#destroy', as: :destroy_suggestion
  get 'suggestion/:id/add'  => 'suggestions#add_book', as: :add_suggestion

  resources :library_members
  resources :books
  resources :suggestions
  get 'books/:id/checkout' => 'checkout_histories#checkout',as: :book_checkout
  post 'books/:id/checkout' => 'checkout_histories#checkout_admin',as: :book_admin_checkout
  get 'books/:id/return' => 'checkout_histories#return_book', as: :book_return
  get 'books/:id/history'=> 'checkout_histories#show_book_history',as: :book_history
  get 'library_members/:id/history' => 'checkout_histories#show_member_history',as: :member_history
end
