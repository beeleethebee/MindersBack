# frozen_string_literal: true

require 'rails_helper'
require 'shared/patient'
RSpec.describe 'Api::TherapistsController', type: :request do # rubocop:todo Metrics/BlockLength
  include Rails.application.routes.url_helpers
  include_context 'Basic Patient and headers'
  let!(:therapist) { create(:therapist) }

  describe 'GET /api/therapists/:id' do
    it '200 if success' do
      get api_therapist_path(therapist.id), headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it 'return a 401 if wrong or missing creditentials' do
      get api_therapist_path(therapist.id), headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'return a 404 if therapist not found' do
      get api_therapist_path(0), headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'return the information of the therapist' do
      get api_therapist_path(therapist.id), headers: @headers
      body = JSON.parse(response.body)
      expect(body.keys).to include('id', 'email', 'first_name', 'last_name', 'address')
    end
  end

  describe 'GET /api/therapists/:id/add' do
    it '201 if success' do
      get add_api_therapist_path(therapist.id), headers: @headers
      expect(response).to have_http_status(:created)
    end

    it 'return a 401 if wrong or missing creditentials' do
      get add_api_therapist_path(therapist.id), headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'return a 404 if therapist not found' do
      get add_api_therapist_path(0), headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'update the therapist of the patient' do
      get add_api_therapist_path(therapist.id), headers: @headers
      expect(Patient.find(patient.id).therapist).to eq(therapist)
    end
  end
end
