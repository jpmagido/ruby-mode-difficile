# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Academy::TimeSlotsController', type: :request do
  let(:time_slot) { create(:time_slot) }
  let(:current_user) { User.find_by_login('jpmagido') }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:student, user: current_user, status: :ready)
  end

  describe 'PATCH /update' do
    it 'updates student_approval' do
      expect(time_slot.student_approval).to be_falsey
      patch academy_mentorship_session_time_slot_path(time_slot.mentorship_session, time_slot, student_approval: true)
      expect(time_slot.reload.student_approval).to be_truthy
    end
  end

end
