require 'rails_helper'

RSpec.describe "Academy::MentorshipSessions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/academy/mentorship_sessions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/academy/mentorship_sessions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/academy/mentorship_sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/academy/mentorship_sessions/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
