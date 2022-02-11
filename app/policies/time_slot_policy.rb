# frozen_string_literal: true

class TimeSlotPolicy < AppPolicy
  def update?
    owner?
  end

  private

  def mentorship
    record.mentorship_session
  end

  def owner?
    mentorship&.coach&.user_id == user.id || mentorship&.student&.user_id == user.id
  end
end
