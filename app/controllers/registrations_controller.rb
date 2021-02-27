# frozen_string_literal: true

# User registration, To be used ONLY as a back end API

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  protect_from_forgery with: :null_session, prepend: true
end
