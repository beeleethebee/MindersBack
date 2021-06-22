class StatusesController < TherapistsApplicationController
  def create
    patient = Patient.find(params[:patient])
    Status.create(title: params[:status], patient: patient)
    redirect_to therapists_path
  end
end
