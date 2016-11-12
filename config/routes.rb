Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :transfers

  resources :player_in_teams, only: [:show]

  resources :players do
    member do
      get 'buy_player', to: 'players#buy_player', as: :buy_player
    end
  end

  resources :teams

  resources :stadia

  resources :users

  resources :countries

  resources :club_bases

  resources :sponsors

  resources :teams

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  patch 'logout' => "sessions#destroy", as: :logout
end
