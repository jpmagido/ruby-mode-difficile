# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user
  # TODO: token attribute must be encoded
end
