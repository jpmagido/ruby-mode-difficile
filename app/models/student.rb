# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user

  has_many :mentorships, dependent: :destroy

  has_rich_text :description

  enum status: %i[pending ready blocked]

  delegate :login, to: :user

  def mentorship_sessions
    MentorshipSession.where(id: mentorships.map(&:mentorship_session_ids).flatten)
  end
end
