# frozen_string_literal: true

class ChallengePolicy < AppPolicy
  def index?
    user
  end

  def show?
    user
  end

  def new?
    is_admin_or_coach?
  end

  def create?
    is_admin_or_coach?
  end

  def update?
    record.user_id == user.id && is_admin_or_coach?
  end

  private

  def is_admin_or_coach?
    user&.admin || user&.coach
  end
end
