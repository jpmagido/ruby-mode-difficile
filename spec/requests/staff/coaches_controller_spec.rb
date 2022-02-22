# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::CoachesContorller', type: :request do
  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  let!(:coach) { create(:coach) }

  describe 'GET /index' do
    it 'returns http success' do
      get staff_coaches_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_coach_path(coach)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_coach_path(coach)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:update_params) do
      {
        coach: {
          status: :ready
        }
      }
    end

    it 'updates coach properly' do
      expect(coach.pending?).to be_truthy
      patch staff_coach_path(coach), params: update_params
      expect(coach.reload.ready?).to be_truthy
    end
  end
end
