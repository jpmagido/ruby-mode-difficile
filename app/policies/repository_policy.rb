# frozen_string_literal: true

class RepositoryPolicy < AppPolicy
  def update?
    owner? || user.admin
  end

  private

  def owner?
    record.cloud_storage.user_id == user.id
  end
end
