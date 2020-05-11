Rails.application.routes.draw do

  resources :problems do
    resources :proposals do
      resources :materials
    end
  end
  resources :proposals, only:[:index, :show, :edit, :update, :destroy]
  resources :materials, only:[:index, :show, :edit, :update, :destroy]
  resources :categories
  resources :comments



  post '/problems/:id', to: "problems#create_vote", as: "create_vote"
  #post '/problems/:id', to: "votes#create"

  root to: 'pages#home'
  #devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'users/:id', to: 'users#show', as: "user"
end
