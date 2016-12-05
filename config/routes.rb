Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :transfers

  resources :players, except: [:destroy] do
    member do
      patch 'buy'
      patch 'sell'
    end
  end

  resources :teams, except: [:new, :create]

  resources :stadia, except: [:index] do
    member do
      patch 'level_up'
      patch 'capacity_up'
    end
  end

  resources :users do
    collection do
      get 'registration'
      get 'confirmation'
    end
  end

  resources :countries

  resources :club_bases, except: [:index] do
    member do
      patch 'level_up'
      patch 'training_fields_up'
    end
  end

  resources :sponsors, only: [:show, :edit, :update]

  resources :teams

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  patch 'logout' => "sessions#destroy", as: :logout
end
