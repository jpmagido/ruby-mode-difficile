# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :conversation_messages, dependent: :destroy

  def participant_names
    conversation_participants.map(&:user).map(&:login)
  end

  def send_message(sender_id, message)
    participant_sender = conversation_participants.find_by(user_id: sender_id)
    raise ActiveRecord::RecordNotFound unless participant_sender

    conversation_messages.create!(
      conversation_participant_id: participant_sender.id,
      content: message
    )
  end
end
