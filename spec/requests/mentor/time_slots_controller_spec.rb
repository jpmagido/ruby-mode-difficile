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

  describe 'PATCH /update' do
    it 'updates mentor approval' do
      expect(time_slot.coach_approval).to be_falsey
      patch mentor_mentorship_session_time_slot_path(time_slot.mentorship_session, time_slot), params: { coach_approval: true }
      expect(time_slot.reload.coach_approval).to be_truthy
    end
  end
end
