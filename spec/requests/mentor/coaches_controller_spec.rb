# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor::CoachesController', type: :request do
  before do
    VCR.use_cassette('login') { post session_path }
    create(:coach, user: User.find_by_login('jpmagido'), status: :ready)
  end

  describe 'GET /show' do
    it 'returns http success' do
      get mentor_coach_path
      expect(response).to have_http_status(:success)
    end
  end
end
