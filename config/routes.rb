Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#top'
  get '/terms' => 'home#terms'
  resources :users, except: [:new, :create]
  resources :posts do
  	resources :favorites, only: [:create, :destroy]
  	resources :comments, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
