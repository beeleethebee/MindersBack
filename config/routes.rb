# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :therapists
  resources :therapists, only: %i[index]
  resources :statuses, only: %i[create]

  root 'therapists#home'

  namespace :api, defaults: { format: 'json' } do
    mount_devise_token_auth_for 'Patient', at: 'auth', controllers: {
      registrations: 'api/registrations',
      sessions: 'api/sessions'
      # passwords: 'study_quizz/passwords'
    }
    resources :entries
  end
end
