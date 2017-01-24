Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :transfers

  resources :players, except: [:destroy] do
    member do
      get 'buy_processing'
      patch 'buy'
      patch 'sell'
      patch 'training'
    end
  end

  resources :teams, except: [:new, :create] do
    member do
      get 'statistics'
      get 'operations'
      get 'transfer_history'
      get 'training'
    end
  end

  resources :notifications, only: [:index]

  resources :stadia, except: [:index, :destroy] do
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

  resources :club_bases, except: [:index, :destroy] do
    member do
      patch 'level_up'
      patch 'training_fields_up'
    end
  end

  resources :sponsors, only: [:show, :edit, :update]

  resources :teams, except: [:new, :create]

  get 'login' => "sessions#new", as: :login

  post 'login' => "sessions#create"

  patch 'logout' => "sessions#destroy", as: :logout
end
