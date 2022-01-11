# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :cloud_storage, polymorphic: true

  validates :github_url, format: URI.regexp(%w[https http])

  def repo_name
    github_url.split('/').last
  end

  def owner_name
    cloud_storage.user.login
  end
end
