# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::UsersController', type: :request do
  let!(:user) { create(:user) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /index' do
    it 'returns http success' do
      get staff_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'updates user' do
      patch staff_user_path(user), params: { user: { language: :en } }

      expect(user.reload.language).to eq 'en'
    end
  end

  describe 'DELETE /destroy' do
    it 'delete user' do
      delete staff_user_path(user)
      expect(user.reload.active).to be_falsey
    end

    it 'redirects to user show' do
      delete staff_user_path(user)
      expect(response).to redirect_to staff_user_path(user)
    end
  end
end
