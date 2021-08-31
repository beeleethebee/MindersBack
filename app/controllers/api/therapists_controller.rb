# frozen_string_literal: true

module Api
  class TherapistsController < ApiController
    before_action :set_user
    before_action :set_therapist

    def show; end

    def add
      @patient.update(therapist: @therapist)
      render json: { message: 'success' }, status: :created
    end

    private


    def set_therapist
      @therapist = Therapist.find(params[:id])
    end

    def set_user
      @patient = current_api_patient
    end
  end
end
