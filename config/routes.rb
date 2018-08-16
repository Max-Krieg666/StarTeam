Rails.application.routes.draw do
  root 'sessions#new'

  resources :transfers

  resources :players, except: :destroy do
    member do
      get 'buy_processing'
      patch 'buy'
      patch 'sell'
      patch 'training'

      # characteristics upgrade
      patch 'tackling_upgrade'
      patch 'marking_upgrade'
      patch 'positioning_upgrade'
      patch 'heading_upgrade'
      patch 'pressure_upgrade'
      patch 'shot_accuracy_upgrade'
      patch 'shot_power_upgrade'
      patch 'dribbling_upgrade'
      patch 'passing_upgrade'
      patch 'carport_upgrade'
      patch 'speed_upgrade'
      patch 'endurance_upgrade'
      patch 'reaction_upgrade'
      patch 'aggression_upgrade'
      patch 'creativity_upgrade'
    end
  end

  resources :teams, except: %i[new create] do
    member do
      get 'statistics'
      get 'operations'
      get 'transfer_history'
      get 'training'
      get 'line_up'
      get 'get_players'
    end

    resources :stadia, except: %i[index destroy] do
      member do
        patch 'level_up'
        patch 'capacity_up'
      end
    end

    resources :club_bases, except: %i[index destroy] do
      member do
        patch 'level_up'
        patch 'training_fields_up'
      end
    end

    resources :sponsors, only: %i[show edit update]
  end

  resources :notifications, only: :index

  resources :users do
    collection do
      get 'registration'
      get 'confirmation'
    end
  end

  resources :countries

  resources :tournaments, only: :index do
    collection do
      get 'all'
      get 'friendly'
    end
  end
  resources :leagues do
    post 'join', on: :member
  end
  resources :cups do
    post 'join', on: :member
  end

  resources :games

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  patch 'logout' => 'sessions#destroy', as: :logout
end
