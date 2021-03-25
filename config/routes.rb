Rails.application.routes.draw do
  # mount_devise_token_auth_for 'Patient', at: 'auth'
  namespace :api do
    mount_devise_token_auth_for 'Patient', at: 'auth', controllers: {
        registrations: 'api/registrations',
        sessions: 'api/sessions'
        # passwords: 'study_quizz/passwords'
    }
  end
end
