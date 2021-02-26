# frozen_string_literal: true

Rails.application.routes.draw do
  resources :patients
  resources :therapists


  mount_devise_token_auth_for 'Therapist', at: 'auth/therapists/'
  mount_devise_token_auth_for 'Patient', at: 'auth/patient/'

end
