# frozen_string_literal: true

class Coach < ApplicationRecord
  belongs_to :user

  has_many :mentorships

  enum status: %i[pending ready blocked]
end
