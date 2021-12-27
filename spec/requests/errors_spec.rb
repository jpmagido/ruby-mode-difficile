require 'rails_helper'

RSpec.describe "Errors", type: :request do
  describe "GET /404" do
    it "returns http success" do
      get "/errors/404"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /401" do
    it "returns http success" do
      get "/errors/401"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /500" do
    it "returns http success" do
      get "/errors/500"
      expect(response).to have_http_status(:success)
    end
  end

end
