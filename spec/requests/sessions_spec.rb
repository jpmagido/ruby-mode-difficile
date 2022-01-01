require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get new_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    xit 'returns http success', :vcr do
      VCR.use_cassette('session-edit') do
        get edit_session_path, params: { state: ENV['GITHUB_REDIRECT_TOKEN'] }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    xit 'redirects to user show' do
      expect(post(session_path, params: {})).to redirect_to user_path
      #expect(response).to have_http_status(:success)
    end
  end
end
