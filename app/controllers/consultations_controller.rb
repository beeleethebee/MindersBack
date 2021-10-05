# frozen_string_literal: true

class ConsultationsController < TherapistsApplicationController
  before_action :set_consultation, only: %i[show edit update destroy]

  # GET /sessions
  def index
    @consultations = @therapist.consultations.includes(:patient)
  end

  # GET /sessions/1
  def show
    last_consultation = @consultation.patient.consultations
                                     .where('schedule_time < ?', @consultation.schedule_time)
                                     .order(schedule_time: :desc).first
    @entries = @consultation.patient.entries.where('entries.time < ?', @consultation.schedule_time)
    @entries = @entries.where('entries.time > ?', last_consultation.schedule_time) unless last_consultation.nil?
  end

  # GET /sessions/new
  def new
    @consultation = Consultation.new
  end

  # GET /sessions/1/edit
  def edit; end

  # POST /sessions or /sessions.json
  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.therapist = @therapist
    if @consultation.save
      redirect_to consultations_path, notice: 'Consultation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sessions/1
  def update
    if @consultation.update(consultation_params)
      redirect_to @consultation, notice: 'Consultation was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  def destroy
    @consultation.destroy
    redirect_to consultations_url, notice: 'Consultation was successfully destroyed.'
  end

  private

  def set_consultation
    @consultation = Consultation.find(params[:id])
    raise ActiveRecord.RecordInvalid if @consultation.therapist != @therapist
  end

  def consultation_params
    params.require(:consultation).permit(:schedule_time, :patient_id, :note)
  end
end
