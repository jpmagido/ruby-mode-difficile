# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception
  has_many :conversation_participants, dependent: :destroy

  has_one :session, dependent: :destroy
  has_one :admin, dependent: :destroy
  has_one :coach, dependent: :destroy

  enum language: %i[fr en]

  scope :admins, -> { joins(:admin) }

  def owns_answer?(answer_id)
    answers.ids.include?(answer_id)
  end

  def owns_challenge?(challenge_id)
    challenges.ids.include?(challenge_id)
  end
end
