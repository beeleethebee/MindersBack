class PatientsController < TherapistsApplicationController
  before_action :set_patient, only: %i[show remove]

  def show
    @consultations = @patient.consultations.order(:schedule_time)
    @entries = @patient.entries.order(time: :desc).page(params[:page] || 0).per(10)
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

  def remove
    @patient.update(therapist: nil)
    redirect_to root_path, notice: "#{@patient.first_name} #{@patient.last_name} n'est plus à votre charge"
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
