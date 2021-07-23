require 'rails_helper'
require 'shared/patient'
RSpec.describe 'Api::Categories', type: :request do
  include Rails.application.routes.url_helpers
  include_context 'Basic Patient and headers'

  describe 'GET /index' do
    it '200 if headers' do
      get api_categories_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it '401 if not authorized' do
      get api_categories_path, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    describe 'it return categories' do
      let!(:category_count) { rand(10...100)}
      let!(:categories) { create_list(:category, category_count, patient: nil) }

      it 'returns all generics categories' do
        get api_categories_path, headers: @headers
        categories_json = JSON.parse response.body
        expect(categories_json.size).to eq(category_count)
      end

      it 'also returns patient categories' do
        create_list(:category, category_count, patient: patient)
        get api_categories_path, headers: @headers
        categories_json = JSON.parse response.body
        expect(categories_json.size).to eq(category_count * 2)
      end

      it 'not return other patient categories' do
        create_list(:category, category_count, patient: create(:patient))
        get api_categories_path, headers: @headers
        categories_json = JSON.parse response.body
        expect(categories_json.size).to eq(category_count)
      end

      it 'render the id, name of each category' do
        get api_categories_path, headers: @headers
        category_names = categories.map(&:name)
        category_ids = categories.map(&:id)
        categories_json = JSON.parse response.body
        expect(categories_json.map{|el| el['name']}).to match_array(category_names)
        expect(categories_json.map{|el| el['id']}).to match_array(category_ids)
      end
    end
  end

  describe 'GET /create' do
    let!(:category_attributes) { attributes_for(:category, patient: patient) }

    it '200 if headers and correct params' do
      post api_categories_path, params: category_attributes, headers: @headers
      expect(response).to have_http_status(:created)
    end

    it '401 if not authorized' do
      post api_categories_path, params: category_attributes, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it '400 missing params' do
      post api_categories_path, params: {}, headers: @headers
      expect(response).to have_http_status(:bad_request)
    end

    it 'create a category and attach it to Patient' do
      post api_categories_path, params: category_attributes, headers: @headers
      expect(patient.categories.size).to eq(1)
    end

    it 'cannot two categories with same name' do
      name = 'MA CATEGORIE'
      create(:category, name: name, patient: patient)
      post api_categories_path, params: { name: name }, headers: @headers
      expect(response).to have_http_status(:bad_request)
    end

  end

  describe 'GET /destroy/:id' do
    let!(:category) { create(:category, patient: patient) }

    it '204 if headers and correct params' do
      delete api_category_path(category.id), headers: @headers
      expect(response).to have_http_status(:no_content)
    end

    it '401 if not authorized' do
      delete api_category_path(category.id), headers: {}
      expect(response).to have_http_status(:unauthorized)
    end

    it '404 if not found' do
      delete api_category_path(0), headers: @headers
      expect(response).to have_http_status(:not_found)
    end

    it '401 if its a generic category' do
      generic_category = create(:category, patient: nil)
      delete api_category_path(generic_category.id), headers: @headers
      expect(response).to have_http_status(:unauthorized)
    end

    it '401 if its not your category' do
      other_category = create(:category, patient: create(:patient))
      delete api_category_path(other_category.id), headers: @headers
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
