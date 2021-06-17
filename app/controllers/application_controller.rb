# frozen_string_literal: true

#:nodoc:
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_therapist!
  before_action :set_therapist

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password first_name last_name address])
  end

  private

  def set_therapist
    @therapist = current_therapist
  end
end
