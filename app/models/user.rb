# frozen_string_literal: true

class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :challenges, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception
  has_many :conversation_participants, dependent: :destroy

  has_one :session, dependent: :destroy
  has_one :linkedin_session, dependent: :destroy
  has_one :admin, dependent: :destroy
  has_one :coach, dependent: :destroy
  has_one :student, dependent: :destroy

  enum language: %i[fr en]

  scope :admins, -> { joins(:admin) }

  def self.language_attributes_for_select
    languages.keys.to_a.map { |key| [I18n.t("shared.languages.#{key}"), key] }
  end

  def owns_answer?(answer_id)
    answers.ids.include?(answer_id)
  end

  def owns_challenge?(challenge_id)
    challenges.ids.include?(challenge_id)
  end

  def admin_page
    staff_user_path(self)
  end

  def conversations
    conversation_participants.map(&:conversation).uniq
  end
end
