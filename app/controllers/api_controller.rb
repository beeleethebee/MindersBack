# frozen_string_literal: true

class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_patient!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    respond_with '{"error": "not_found"}', status: :not_found
  end
end

