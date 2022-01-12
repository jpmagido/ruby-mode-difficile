# frozen_string_literal: true

class ChallengePolicy < AppPolicy
  def index?
    user
  end

  def show?
    user
  end

  def new?
    user
  end

  def create?
    user # limit to Users with a certain level
  end

  def update?
    record.user_id == user.id
  end
end
