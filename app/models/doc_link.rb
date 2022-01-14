# frozen_string_literal: true

class DocLink < ApplicationRecord
  belongs_to :doc
  belongs_to :linkable, polymorphic: true
end
