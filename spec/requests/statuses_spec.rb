require 'rails_helper'

RSpec.describe "Statuses", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/statuses/create"
      expect(response).to have_http_status(:success)
    end
  end

end
