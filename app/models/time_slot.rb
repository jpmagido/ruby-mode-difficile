# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  belongs_to :mentorship_session

  after_update_commit lambda {
    broadcast_replace_to mentorship_session,
                         partial: 'mentor/time_slots/time_slot'
  }

  def approved
    coach_approval && student_approval
  end
end
