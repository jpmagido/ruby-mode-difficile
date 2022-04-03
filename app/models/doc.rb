# frozen_string_literal: true

class Doc < ApplicationRecord
  has_many :doc_links, dependent: :destroy

  validates_length_of :title, in: 2..200

  enum status: %i[pending ready]

  has_rich_text :content_fr
  has_rich_text :content_en

  scope :all_valid, -> { where('status = 1') }
end
