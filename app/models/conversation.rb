# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :conversation_messages, dependent: :destroy

  def participant_names
    conversation_participants.map(&:user).map(&:login)
  end

  def ask_coach_promotion(user_id)
    future_coach = conversation_participants.find_by(user_id: user_id)
    raise ActiveRecord::RecordNotFound unless future_coach

    conversation_messages.create!(
      conversation_participant_id: future_coach.id,
      content: I18n.t('coaches.messages.admin-promotion', user_path: User.find(user_id).admin_page)
    )
  end
end
