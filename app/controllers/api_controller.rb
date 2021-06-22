# frozen_string_literal: true

#:nodoc:
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_patient!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: 'Not found'}, status: :not_found
  end
end
