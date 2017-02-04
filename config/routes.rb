Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'

  resources :games, only: [:index, :new, :create]
end
