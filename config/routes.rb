Rails.application.routes.draw do
  post 'follows/:id/create' => 'follows#create'
  post 'follows/:id/destroy' => 'follows#destroy'


  post 'comments/create' => 'comments#create'

  get "posts/result" =>"posts#result"
  get  "posts/tag/:tag_name" => "posts#tag"
  resources :posts


  get 'users/index'
  get 'users/new'  => 'users#new'
  post 'users/create' => 'users#create'
  get 'login'  => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'users/:id/follow' => 'users#follow'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' =>'users#update'
  get 'users/:id' => 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'home#index'
end
