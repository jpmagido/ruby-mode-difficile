require 'rails_helper'

RSpec.describe "Mentor::Users", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/mentor/users/show"
      expect(response).to have_http_status(:success)
    end
  end

end
