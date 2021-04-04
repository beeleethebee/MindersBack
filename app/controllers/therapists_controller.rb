# frozen_string_literal: true

#:nodoc:
class TherapistsController < ApplicationController
  before_action :authenticate_therapist!

  def index
    return redirect_to new_therapist_session_url unless therapist_signed_in?

    @therapist = current_therapist
  end
end
