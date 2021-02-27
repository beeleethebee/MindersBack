# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'Therapist', at: '/auth/therapist'
  mount_devise_token_auth_for 'Patient', at: '/auth/patient'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
