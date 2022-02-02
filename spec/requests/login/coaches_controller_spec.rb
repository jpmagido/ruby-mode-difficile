# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::CoachesController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_coach_path
      expect(response).to have_http_status(:success)
    end
  end
end
