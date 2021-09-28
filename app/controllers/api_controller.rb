# frozen_string_literal: true

#:nodoc:
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_patient!

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::UrlGenerationError, with: :render_not_found

  def render_not_found
    render json: { message: 'Not found' }, status: :not_found
  end

  def render_bad_request(full_messages)
    render json: { errors: full_messages }, status: :bad_request
  end
end
