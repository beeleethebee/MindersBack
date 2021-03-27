# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::EntriesController', type: :request do
  include Rails.application.routes.url_helpers

  describe 'GET /api/entries' do
    let!(:patient) { create(:patient) }
    let!(:more_entries) { create_list(:entry, 25) }
    let!(:entries) { create_list(:entry, 5, patient: patient) }
    before do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')
    end

    it 'return all patient entries' do
      get api_entries_path, headers: @headers
      expect(response).to have_http_status(:ok)
      entry_ids = JSON.parse(response.body).map { |entry| entry['id'] }
      expect(entry_ids).to include(*patient.entries.pluck(:id))
    end

    it 'return a 401 if wrong or missing creditentials' do
      get api_entries_path, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/entries/:id' do
    let!(:patient) { create(:patient) }
    let!(:more_entries) { create_list(:entry, 25) }
    let!(:entries) { create_list(:entry, 5, patient: patient) }
    before do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')
    end

    it 'return all the information of an entry' do
      entries.each do |entry|
        get api_entry_path entry.id, @headers
        expect(response).to have_http_status(:ok)
        entry_id = JSON.parse(response.body)['id']
        expect(entry_id).to eq(entry.id)
      end
    end

    it 'catch if entry not found' do
      get api_entry_path 0, @headers
      expect(response).to have_http_status(:not_found)
    end

    it 'refuse access to another patient' do
      new_patient = create(:patient)
      post api_patient_session_path, params: { email: new_patient.email, password: 'password' }
      headers = response.headers.extract!('uid', 'client', 'access-token')
      get api_entry_path entries.first.id, headers
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /api/entries' do
    let!(:patient) { create(:patient) }
    let!(:entry_attributes) { attributes_for(:entry, patient: patient) }
    before do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')
    end

    it 'can create a new entry' do
      post api_entries_path, params: entry_attributes, headers: @headers
      entry = JSON.parse response.body
      expect(response).to have_http_status(:created)
      expect(entry['context']).to eq(entry_attributes[:context])
    end

    it 'cannot create a new entry if wrong creditentials' do
      post api_entries_path, params: entry_attributes, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'cannot create a new entry if it miss any field' do
      post api_entries_path, params: {}, headers: @headers
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body['errors'].keys).to include('context', 'location', 'time')
    end
  end

  describe 'PATCH /api/entries/:id' do
    let!(:patient) { create(:patient) }
    let!(:entry) { create(:entry, patient: patient) }
    before do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')
    end

    it 'can update an existing entry' do
      params = { 'context' => 'Prout', 'location' => 'Prat' }
      patch api_entry_url entry, params.merge(@headers)
      expect(response).to have_http_status(:ok)
      expect(Entry.find(entry.id).context).to eq(params['context'])
      expect(Entry.find(entry.id).location).to eq(params['location'])
    end

    it 'catch if entry not found' do
      patch api_entry_url 0, @headers
      expect(response).to have_http_status(:not_found)
    end

    it '401 if wrong or missing creditentials' do
      params = { 'context' => 'Prout', 'location' => 'Prat' }
      patch api_entry_url entry, params
      expect(response).to have_http_status(:unauthorized)

      new_patient = create(:patient)
      post api_patient_session_path, params: { email: new_patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')

      patch api_entry_url entry, params.merge(@headers)
      expect(response).to have_http_status(:unauthorized)
      expect(Entry.find(entry.id).context).to eq(entry.context)
      expect(Entry.find(entry.id).location).to eq(entry.location)
    end
  end

  describe 'DELETE /api/entries/:id' do
    let!(:patient) { create(:patient) }
    let!(:entry) { create(:entry, patient: patient) }
    before do
      post api_patient_session_path, params: { email: patient.email, password: 'password' }
      @headers = response.headers.extract!('uid', 'client', 'access-token')
    end

    it 'can destroy an entry' do
      delete api_entry_path entry.id, @headers
      expect(response).to have_http_status(:no_content)
    end

    it 'cannot destroy an entry form an other patient' do
      new_entry = create(:entry)
      delete api_entry_path new_entry.id, @headers
      expect(response).to have_http_status(:unauthorized)
    end

    it 'cannot destroy an unexistant entry' do
      delete api_entry_path 1, @headers
      expect(response).to have_http_status(:not_found)
    end
  end
end
