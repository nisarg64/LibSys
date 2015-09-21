Rails.application.routes.draw do
  get 'sessions/new'
  get 'library_members/new'
  get 'library_members/home'
  get 'helper_pages/about'
  get 'helper_pages/contact'
  get 'helper_pages/home'

  root             'helper_pages#home'
  get 'about'   => 'helper_pages#about'
  get 'contact' => 'helper_pages#contact'
  get 'signup'  => 'library_members#new'
  get    'admin_login'   => 'sessions#new_admin'
  post   'admin_login'   => 'sessions#create_admin'
  get    'member_login'   => 'sessions#new_member'
  post   'member_login'   => 'sessions#create_member'
  delete 'logout'  => 'sessions#destroy'
  resources :library_members
end
