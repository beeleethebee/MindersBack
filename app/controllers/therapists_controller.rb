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

  def profile
    @qr_code = RQRCode::QRCode.new(@therapist.id.to_s)
    @svg_qr = @qr_code.as_svg
  end

  def delete
    @therapist.destroy
    redirect_to root_path
  end
end
