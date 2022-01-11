# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :cloud_storage, polymorphic: true

  validates :github_url, format: URI.regexp(%w[https http])

  def readme
    markdown.render super
  end

  private

  def markdown
    ::Redcarpet::Markdown.new(::Redcarpet::Render::HTML)
  end
end
