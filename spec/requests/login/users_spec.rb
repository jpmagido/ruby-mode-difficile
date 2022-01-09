# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::UsersController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /show' do
    it 'returns http success' do
      get login_user_path
      expect(response).to have_http_status(:success)
    end
  end
end
