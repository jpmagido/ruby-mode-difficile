require 'rails_helper'

RSpec.describe "Staff::Coaches", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/staff/coaches/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/staff/coaches/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/staff/coaches/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
