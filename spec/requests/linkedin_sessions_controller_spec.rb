# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LinkedinSessionsController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /new' do
    it 'returns http success' do
      get new_linkedin_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    xit 'returns http success' do
      VCR.use_cassette('linkedin-login-step2') do
        get edit_linkedin_session_path, params: { state: ENV['LINKEDIN_REDIRECT_TOKEN'], code: 'code from linkedin API' }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
