# frozen_string_literal: true

module Api
  class CategoriesController < ApiController
    before_action :set_user

    def index
      @categories = Category.where(patient_id: [nil, @patient.id])
    end

    def create
      @category = Category.new(name: params[:name], patient: @patient)
      if @category.save
        render partial: 'category', locals: { category: @category }, status: :created
      else
        render_bad_request(@category.errors.full_messages)
      end
    end

    def destroy
      @category = Category.find(params[:id])
      if @category.patient == @patient
        @category.destroy
      else
        head :unauthorized
      end
    end

    private

    def set_user
      @patient = current_api_patient
    end
  end
end
