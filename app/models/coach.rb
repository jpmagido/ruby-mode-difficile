# frozen_string_literal: true

class Coach < ApplicationRecord
  belongs_to :user

  has_many :mentorships, dependent: :destroy

  enum status: %i[pending ready blocked]
end
