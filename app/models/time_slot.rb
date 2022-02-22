# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  belongs_to :mentorship_session

  after_update_commit lambda {
    broadcast_replace_to "mentor_mentorship_session_#{mentorship_session.id}",
                         partial: 'mentor/time_slots/time_slot'

    broadcast_replace_to "student_mentorship_session_#{mentorship_session.id}",
                         partial: 'academy/time_slots/time_slot'
  }

  def approved
    coach_approval && student_approval
  end
end
