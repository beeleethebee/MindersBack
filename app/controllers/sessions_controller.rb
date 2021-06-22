class SessionsController < TherapistsApplicationController
  before_action :set_session, only: %i[show edit update destroy]

  # GET /sessions
  def index
    @sessions = @therapist.sessions.includes(:patient)
  end

  # GET /sessions/1
  def show; end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit; end

  # POST /sessions or /sessions.json
  def create
    @session = Session.new(session_params)
    @session.therapist = @therapist
    if @session.save
      redirect_to sessions_path, notice: 'Session was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sessions/1
  def update
    if @session.update(session_params)
      redirect_to @session, notice: 'Session was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
    redirect_to sessions_url, notice: 'Session was successfully destroyed.'
  end

  private

  def set_session
    @session = Session.find(params[:id])
    raise ActiveRecord.RecordInvalid if @session.therapist != @therapist
  end

  def session_params
    params.require(:session).permit(:schedule_time, :patient_id)
  end
end
