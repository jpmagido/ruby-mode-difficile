# frozen_string_literal: true

class AnswerPolicy < AppPolicy
  def index?
    user
  end

  def show?
    author_or_admin? || user.answers.ready.map(&:challenge).include?(record.challenge)
  end

  def new?
    user
  end

  def create?
    user # limit to Users with a certain level
  end

  def update?
    author_or_admin?
  end

  private

  def author_or_admin?
    record.user_id == user.id || user.admin
  end
end
