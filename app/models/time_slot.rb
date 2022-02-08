# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  belongs_to :mentorship_session

  def approved
    coach_approval && student_approval
  end
end
