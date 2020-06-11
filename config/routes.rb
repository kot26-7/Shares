Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#top'
  get '/terms' => 'home#terms'
  resources :users, except: [:new, :create] do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
