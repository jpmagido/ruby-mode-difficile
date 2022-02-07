# frozen_string_literal: true

class Coach < ApplicationRecord
  belongs_to :user

  has_many :mentorships, dependent: :destroy
  has_many :mentorship_sessions, through: :mentorships

  has_rich_text :description

  enum status: %i[pending ready blocked]

  delegate :login, to: :user
end
