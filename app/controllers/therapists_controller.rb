# frozen_string_literal: true

#:nodoc:
class TherapistsController < TherapistsApplicationController
  skip_before_action :authenticate_therapist!, only: [:home]
  skip_before_action :set_therapist, only: [:home]


  def home
    redirect_to therapists_path unless current_therapist&.id.nil?
  end

  def index
    @patients = @therapist.patients.includes(:statuses)
  end

end
