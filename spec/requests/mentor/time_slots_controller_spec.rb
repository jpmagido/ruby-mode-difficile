# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor::TimeSlotsController', type: :request do
  let(:mentorship_session) { create(:mentorship_session, mentorship: create(:mentorship, coach: current_user.coach)) }
  let(:time_slot) { create(:time_slot, mentorship_session: mentorship_session) }
  let(:current_user) { User.find_by_login('jpmagido') }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:coach, user: current_user, status: :ready)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get mentor_mentorship_session_time_slots_path(time_slot.mentorship_session)
      expect(response).to have_http_status(:success)
    end
  end
end
