# frozen_string_literal: true

module Api
  class RegistrationsController < DeviseTokenAuth::RegistrationsController # rubocop:todo Style/Documentation
    protect_from_forgery with: :null_session, prepend: true

    def sign_up_params
      params.permit(:email, :password, :last_name, :first_name)
    end
  end
end
