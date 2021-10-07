# frozen_string_literal: true

module Api
  class EntriesController < ApiController # rubocop:todo Style/Documentation
    before_action :set_entry, only: %i[show update destroy]
    before_action :set_user

    # GET /api/entries
    def index
      @entries = @patient.entries
    end

    # GET /api/entries/1
    def show
      render json: '', status: :unauthorized unless @entry.patient == @patient
    end

    # POST /api/entries
    def create
      @entry = Entry.new(entry_params)
      @categories = Category.where(id: params[:category_ids])
      @entry.patient = @patient
      if @entry.save
        @entry.categories << @categories
        render 'api/entries/show', status: :created, entry: @entry
      else
        render json: { errors: @entry.errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/entries/1
    def update
      return render json: '', status: :unauthorized unless @entry.patient == @patient

      @entry.update(entry_params)
      @categories = Category.where(id: params[:category_ids])
      @entry.categories = @categories
      render 'api/entries/show', status: :ok, entry: @entry
    end

    # DELETE /api/entries/1
    def destroy
      return render json: '', status: :unauthorized unless @entry.patient == @patient

      @entry.destroy
      render json: '', status: :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.permit(:location, :context, :time)
    end

    def set_user
      @patient = current_api_patient
    end
  end
end
