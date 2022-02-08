# frozen_string_literal: true

class ChallengePolicy < AppPolicy
  def index?
    user
  end

  def show?
    user
  end

  def new?
    user&.admin || user&.coach
  end

  def create?
    user&.admin || user&.coach
  end

  def update?
    record.user_id == user.id
  end
end
