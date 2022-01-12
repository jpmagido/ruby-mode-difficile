# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get new_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    # Use capybara
  end

  describe 'POST /create' do
    it 'redirects to login user show' do
      VCR.use_cassette('login') do
        expect(post(session_path)).to redirect_to login_user_path
      end
    end

    it 'creates a User' do
      VCR.use_cassette('login') do
        expect { post(session_path) }.to change(Session, :count).by 1
      end
    end
  end

  describe 'DELETE /destroy' do
    before { VCR.use_cassette('login') { post session_path } }

    it { expect(delete(session_path)).to redirect_to root_path }
    it { expect { delete(session_path) }.to change(Session, :count).by(-1) }
  end
end
