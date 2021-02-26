# frozen_string_literal: true

class TherapistsController < ApplicationController
  before_action :set_therapist, only: %i[show edit update destroy]

  # GET /therapists or /therapists.json
  def index
    @therapists = Therapist.all
  end

  # GET /therapists/1 or /therapists/1.json
  def show; end

  # GET /therapists/new
  def new
    @therapist = Therapist.new
  end

  # GET /therapists/1/edit
  def edit; end

  # POST /therapists or /therapists.json
  def create
    @therapist = Therapist.new(therapist_params)

    respond_to do |format|
      if @therapist.save
        format.html { redirect_to @therapist, notice: 'Therapist was successfully created.' }
        format.json { render :show, status: :created, location: @therapist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /therapists/1 or /therapists/1.json
  def update
    respond_to do |format|
      if @therapist.update(therapist_params)
        format.html { redirect_to @therapist, notice: 'Therapist was successfully updated.' }
        format.json { render :show, status: :ok, location: @therapist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /therapists/1 or /therapists/1.json
  def destroy
    @therapist.destroy
    respond_to do |format|
      format.html { redirect_to therapists_url, notice: 'Therapist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_therapist
    @therapist = Therapist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def therapist_params
    params.require(:therapist).permit(:first_name, :last_name, :address)
  end
end
