require 'rails_helper'

RSpec.describe "Mentor::Students", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/mentor/students/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/mentor/students/index"
      expect(response).to have_http_status(:success)
    end
  end

end
