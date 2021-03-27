# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    mount_devise_token_auth_for 'Patient', at: 'auth', controllers: {
      registrations: 'api/registrations',
      sessions: 'api/sessions'
      # passwords: 'study_quizz/passwords'
    }
    resources :entries
  end
end
