class PatientsController < TherapistsApplicationController
  before_action :set_patient, only: %i[show]

  def show
    @consultations = @patient.consultations.order(:schedule_time)
    @entries = @patient.entries
    set_grouped_entries
  end

  def create
    @patient = Patient.find_by_id(params[:patient_id])
    return redirect_to root_path, notice: 'Patient introuvable' if @patient.nil?

    @therapist.patients << @patient
    redirect_to root_path, notice: 'Patient ajouté'
  end

  def create_fake
    FactoryBot.create(:patient, therapist: @therapist)
    redirect_to root_path, notice: 'Patient créé'
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def set_grouped_entries
    @grouped_entries = {}
    @consultations.each_with_index do |consultation, index|
      grouped_entries = @entries.where('entries.created_at < ?', consultation.schedule_time)
      if index.positive?
        grouped_entries = grouped_entries.where('entries.created_at > ? ', @consultations[index - 1].schedule_time)
      end
      @grouped_entries[consultation.id] = grouped_entries
    end
  end
end
