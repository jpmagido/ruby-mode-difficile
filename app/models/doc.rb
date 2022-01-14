# frozen_string_literal: true

class Doc < ApplicationRecord
  validates_length_of :title, in: 2..200

  has_rich_text :content
end
