# frozen_string_literal: true

module Api
  class EntriesController < ApplicationController # rubocop:todo Style/Documentation
    before_action :set_entry, only: %i[show update destroy]
    before_action :authenticate_patient!
    before_action :set_user

    # GET /api/entries
    def index
      @entries = Entry.all
    end

    # GET /api/entries/1
    def show; end

    # POST /api/entries
    def create
      @entry = Entry.new(entry_params)
      if @entry.save
        render :show, status: :created, location: @entry
      else
        render json: @entry.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/entries/1
    def update
      if @entry.update(entry_params)
        render :show, status: :ok, location: @entry
      else
        render json: @entry.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/entries/1
    def destroy
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
      params.fetch(:entry, {})
    end

    def set_user
      @user = current_user
    end
  end
end
