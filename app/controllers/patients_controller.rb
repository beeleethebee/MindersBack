class PatientsController < TherapistsApplicationController
  before_action :set_patient, only: %i[show]
  def show; end

  def create
    @patient = Patient.find_by_id(params[:patient_id])
    return redirect_to therapists_path, notice: 'Patient introuvable' if @patient.nil?

    @therapist.patients << @patient
    redirect_to therapists_path, notice: 'Patient ajouté'
  end

  def create_fake
    FactoryBot.create(:patient, therapist: @therapist)
    redirect_to therapists_path, notice: 'Patient créé'
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
