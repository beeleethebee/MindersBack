# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AuthSystem', type: :request do
  include Rails.application.routes.url_helpers
  describe 'POST /api/auth/' do
    let!(:patient) { attributes_for(:patient) }

    it 'can create an account' do
      post api_patient_registration_path, params: patient
      expect(response).to have_http_status(:ok)
    end

    it 'cannot use twice the same email' do
      post api_patient_registration_path, params: patient
      patient[:first_name] = 'Matteo'
      patient[:last_name] = 'Brouard'
      post api_patient_registration_path, params: patient
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'cannot let empty first_name and last_name fields' do
      patient[:first_name] = ''
      patient[:last_name] = nil
      patient[:email] = nil

      post api_patient_registration_path, params: patient
      body = JSON.parse(response.body)
      expect(body['errors']).to have_key('first_name')
      expect(body['errors']).to have_key('last_name')
      expect(body['errors']).to have_key('email')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /api/auth/sign_in' do
    let!(:patient) { create(:patient) }

    it 'can successfully login' do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      expect(response).to have_http_status(:ok)
    end

    it 'cannot login if there is a wrong password' do
      post api_patient_session_path, params: { email: patient.email, password: 'wrong password' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'collect headers for futher requests' do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      headers = response.headers.extract!('uid', 'access-token', 'client')
      expect(headers['uid']).to eq(patient.email)
      expect(headers['access-token']&.empty?).to eq(false)
      expect(headers['client']&.empty?).to eq(false)
    end
  end

  describe 'DELETE /api/auth/sign_out' do
    let!(:patient) { create(:patient) }

    it 'can sign out' do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      headers = response.headers.extract!('uid', 'access-token', 'client')
      delete destroy_api_patient_session_path, headers: headers
      expect(response).to have_http_status(:ok)

      get api_auth_validate_token_path, headers: headers
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
