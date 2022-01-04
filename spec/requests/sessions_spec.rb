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
    xit 'returns http success', :vcr do
      VCR.use_cassette('session-edit') do
        get edit_session_path, params: { state: ENV['GITHUB_REDIRECT_TOKEN'] }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    it { expect(post(session_path)).to redirect_to login_user_path }
    it { expect { post(session_path) }.to change(Session, :count).by 1 }
  end

  describe 'DELETE /destroy' do
    before { post session_path }

    it { expect(delete(session_path)).to redirect_to root_path }
    it { expect { delete(session_path) }.to change(Session, :count).by(-1) }
  end
end
