# frozen_string_literal: true

require 'rails_helper'
require 'shared/patient'
RSpec.describe 'Api::EntriesController', type: :request do # rubocop:todo Metrics/BlockLength
  include Rails.application.routes.url_helpers

  describe 'GET /api/entries' do
    include_context 'Basic Patient and headers'
    let!(:more_entries) { create_list(:entry, 25) }
    let!(:entries) { create_list(:entry, 5, patient: patient) }

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

  describe 'GET /api/entries/:id' do # rubocop:todo Metrics/BlockLength
    include_context 'Basic Patient and headers'
    let!(:entry) { create(:entry, patient: patient, with_categories: true) }

    it '200 if patient allowed and entry exist' do
      get api_entry_path entry.id, @headers
      expect(response).to have_http_status(:ok)
    end

    it 'return all the information of an entry' do
      get api_entry_path entry.id, @headers
      body = JSON.parse(response.body)
      expect(body.keys).to include('id', 'location', 'time', 'categories')
    end

    it 'return all information of categories' do
      get api_entry_path entry.id, @headers
      body = JSON.parse(response.body)
      body['categories'].each do |category|
        expect(category.keys).to include('id', 'name')
      end
    end

    it '401 if not authorized' do
      get api_entry_path entry.id, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it '404 if entry not found' do
      get api_entry_path 0, @headers
      expect(response).to have_http_status(:not_found)
    end

    it 'refuse access to another patient' do
      new_entry = create(:entry, patient: create(:patient))
      get api_entry_path new_entry.id, @headers
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /api/entries' do
    include_context 'Basic Patient and headers'
    let!(:entry_attributes) { attributes_for(:entry, patient: patient) }

    it 'can create a new entry' do
      post api_entries_path, params: entry_attributes, headers: @headers
      entry = JSON.parse response.body
      expect(response).to have_http_status(:created)
      expect(entry['context']).to eq(entry_attributes[:context])
    end

    it 'can create a new entry with categories' do
      categories = create_list(:category, 5, patient: nil)
      params = { **entry_attributes, category_ids: categories.map(&:id) }
      post api_entries_path, params: params, headers: @headers
      entry = JSON.parse response.body
      expect(response).to have_http_status(:created)
      expect(entry['context']).to eq(entry_attributes[:context])
      expect(entry['location']).to eq(entry_attributes[:location])
      expect(entry['categories'].size).to eq(5)
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

  describe 'PATCH /api/entries/:id' do # rubocop:todo Metrics/BlockLength
    include_context 'Basic Patient and headers'
    let!(:entry) { create(:entry, patient: patient, with_categories: true) }

    it 'can update an existing entry' do
      params = { 'context' => 'Prout', 'location' => 'Prat' }
      patch api_entry_url entry, params.merge(@headers)
      expect(response).to have_http_status(:ok)
      refreshed_entry = Entry.find(entry.id)
      expect(refreshed_entry.context).to eq(params['context'])
      expect(refreshed_entry.location).to eq(params['location'])
      expect(refreshed_entry.categories.size).to eq(0)
    end

    it 'can update categories' do
      params = { category_ids: patient.categories.sample(2) }
      patch api_entry_url entry, params.merge(@headers)
      expect(response).to have_http_status(:ok)
      refreshed_entry = Entry.find(entry.id)
      expect(refreshed_entry.categories.size).to eq(2)
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
    include_context 'Basic Patient and headers'
    let!(:entry) { create(:entry, patient: patient) }

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
