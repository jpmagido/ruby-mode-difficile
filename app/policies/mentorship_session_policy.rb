# frozen_string_literal: true

class MentorshipSessionPolicy < AppPolicy
  def new?
    user_student_or_coach
  end

  def create?
    belong_to_mentorship
  end

  def update?
    belong_to_mentorship
  end

  def destroy?
    belong_to_mentorship
  end

  private

  def belong_to_mentorship
    record.mentorship.coach_id == user.coach&.id || record.mentorship.student_id == user.student&.id
  end

  def user_student_or_coach
    user.student || user.coach
  end
end
