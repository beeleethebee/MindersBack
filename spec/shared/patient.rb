# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'Basic Patient and headers' do
  include Rails.application.routes.url_helpers

  let!(:patient) { create(:patient) }

  before do
    post api_patient_session_path, params: { email: patient.email, password: 'password' }
    @headers = response.headers.extract!('uid', 'client', 'access-token')
  end
end
