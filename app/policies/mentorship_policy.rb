# frozen_string_literal: true

class MentorshipPolicy < AppPolicy
  def create?
    owner?
  end

  def update?
    owner?
  end

  private

  def owner?
    record&.coach&.user_id == user.id || record&.student&.user_id == user.id
  end
end
