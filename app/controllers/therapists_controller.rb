class TherapistsController < ApplicationController
  before_action :authenticate_therapist!

  def index
    unless therapist_signed_in?
      return redirect_to new_therapist_session_url
    end
    @therapist = current_therapist
  end
end
