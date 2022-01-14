# frozen_string_literal: true

class DocLinkPolicy < AppPolicy
  def create?
    linkable_owner? || user.admin
  end

  private

  def linkable_owner?
    record.linkable.user_id == user.id
  end
end
