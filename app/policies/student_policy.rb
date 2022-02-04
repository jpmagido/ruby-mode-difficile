# frozen_string_literal: true

class StudentPolicy < AppPolicy
  def show?
    owner? || user.admin
  end

  def update?
    owner? || user.admin
  end

  private

  def owner?
    record.user_id == user.id
  end
end
