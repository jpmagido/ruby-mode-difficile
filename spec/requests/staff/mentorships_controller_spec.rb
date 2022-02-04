# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::MentorshipsController', type: :request do
  let(:mentorship) { create(:mentorship) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /index' do
    it 'returns http success' do
      get staff_mentorships_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_mentorship_path(mentorship)
      expect(response).to have_http_status(:success)
    end
  end
end
