# frozen_string_literal: true

module Api
  class EntriesController < ApplicationController # rubocop:todo Style/Documentation
    before_action :set_entry, only: %i[show edit update destroy]

    # GET /api/entries or /api/entries.json
    def index
      @entries = Entry.all
    end

    # GET /api/entries/1 or /api/entries/1.json
    def show; end

    # GET /api/entries/new
    def new
      @entry = Entry.new
    end

    # GET /api/entries/1/edit
    def edit; end

    # POST /api/entries or /api/entries.json
    def create
      @entry = Entry.new(entry_params)

      respond_to do |format|
        if @entry.save
          format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
          format.json { render :show, status: :created, location: @entry }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /api/entries/1 or /api/entries/1.json
    def update
      respond_to do |format|
        if @entry.update(entry_params)
          format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
          format.json { render :show, status: :ok, location: @entry }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /api/entries/1 or /api/entries/1.json
    def destroy
      @entry.destroy
      respond_to do |format|
        format.html { redirect_to api_entries_url, notice: 'Entry was successfully destroyed.' }
        format.json { head :no_content }
      end
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
  end
end
