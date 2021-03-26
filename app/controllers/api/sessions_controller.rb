# frozen_string_literal: true

module Api
  class SessionsController < DeviseTokenAuth::SessionsController
    protect_from_forgery with: :null_session, prepend: true
  end
end
