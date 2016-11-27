Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :transfers

  resources :players do
    member do
      patch 'buy'
      patch 'sell'
    end
  end

  resources :teams, except: [:new, :create]

  resources :stadia

  resources :users do
    collection do
      get 'registration'
      patch 'confirmation'
    end
  end

  resources :countries

  resources :club_bases, except: [:index] do
    member do
      patch 'level_up'
      patch 'training_fields_up'
    end
  end

  resources :sponsors

  resources :teams

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  patch 'logout' => "sessions#destroy", as: :logout
end
