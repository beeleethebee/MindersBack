# frozen_string_literal: true

class PatientsController < TherapistsApplicationController
  before_action :set_patient, only: %i[show remove]

  # GET /patients/:id
  def show
    @consultations = @patient.consultations.order(:schedule_time)
    @entries = @patient.entries.order(time: :desc).page(params[:page] || 0).per(10)
    set_grouped_entries
  end

  # GET /patient/create_fake
  def create_fake
    FactoryBot.create(:patient, therapist: @therapist)
    redirect_to root_path, notice: 'Patient créé'
  end

  # DELETE /patient/:id
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
      grouped_entries = @patient.entries.where('entries.created_at < ?', consultation.schedule_time)
      if index.positive?
        grouped_entries = grouped_entries.where('entries.created_at > ? ', @consultations[index - 1].schedule_time)
      end
      @grouped_entries[consultation.id] = grouped_entries
    end
  end
end
