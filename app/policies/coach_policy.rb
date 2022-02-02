# frozen_string_literal: true

class CoachPolicy < AppPolicy
  def create?
    user.coach.nil?
  end
end
