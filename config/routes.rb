# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :therapists
  resources :therapists, only: %i[index] do
    collection do
      get :profile
      delete :delete
    end
  end
  resources :statuses, only: %i[create]
  resources :consultations

  resources :patients, only: %i[show] do
    member do
      delete :remove
    end
    collection do
      get :create_fake
    end
  end

  root 'therapists#home'

  namespace :api, defaults: { format: 'json' } do
    mount_devise_token_auth_for 'Patient', at: 'auth', controllers: {
      registrations: 'api/registrations',
      sessions: 'api/sessions'
      # passwords: 'study_quizz/passwords'
    }
    resources :entries
    resources :therapists, only: %i[show] do
      member do
        get :add
      end
    end
    resources :categories, only: %i[index create destroy]
  end
end
