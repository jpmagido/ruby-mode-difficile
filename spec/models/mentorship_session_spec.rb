# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MentorshipSession, type: :model do
  let(:today) { DateTime.now }
  let(:first_session) { DateTime.new(today.year, today.month, today.day, 7) }
  let(:last_session) { DateTime.new(today.year, today.month, today.day + 1, 21) }

  let!(:mentorship_session) { create(:mentorship_session, start_date: today, end_date: today + 1) }

  it { expect(mentorship_session).to be_valid }

  describe '#after_create' do
    it 'creates proper number of slots' do
      expect(mentorship_session.time_slots.count).to eq 56
    end

    it 'creates proper range of slots' do
      expect(mentorship_session.time_slots.order(start_date: :asc).first.start_date).to eq first_session
      expect(mentorship_session.time_slots.order(end_date: :desc).first.end_date).to eq last_session
    end

    it 'timeslots have proper duration / 1800 sec == 30 min' do
      time_slot = mentorship_session.time_slots.sample

      expect(time_slot.end_date - time_slot.start_date).to eq 1800.0
    end
  end
end
