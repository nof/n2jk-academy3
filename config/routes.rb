Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  resources :users, only: [:index, :edit, :update] do
    resources :posts do
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
  end

  root to: 'home#index'
end
