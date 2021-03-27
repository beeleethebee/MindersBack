# frozen_string_literal: true

module Api
  class EntriesController < ApiController # rubocop:todo Style/Documentation
    before_action :set_entry, only: %i[show update destroy]
    before_action :set_user

    # GET /api/entries
    def index
      @entries = Entry.all
    end

    # GET /api/entries/1
    def show
      return render json: '', status: :not_found if @entry.nil?

      render json: '', status: :unauthorized unless @entry.patient == @patient
    end

    # POST /api/entries
    def create
      @entry = Entry.new(entry_params)
      @entry.patient = @patient
      if @entry.save
        render 'api/entries/show', status: :created, entry: @entry
      else
        render json: { errors: @entry.errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/entries/1
    def update
      return render json: '', status: :not_found if @entry.nil?
      return render json: '', status: :unauthorized unless @entry.patient == @patient

      if @entry.update(entry_params)
        render 'api/entries/show', status: :ok, entry: @entry
      else
        render json: @entry.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/entries/1
    def destroy
      return render json: '', status: :not_found if @entry.nil?
      return render json: '', status: :unauthorized unless @entry.patient == @patient

      @entry.destroy
      render json: '', status: :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find_by(id: params[:id])
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
