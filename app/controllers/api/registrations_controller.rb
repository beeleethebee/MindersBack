# frozen_string_literal: true

class Api::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protect_from_forgery with: :null_session, prepend: true

end
