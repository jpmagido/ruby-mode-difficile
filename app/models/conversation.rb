# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :conversation_messages, dependent: :destroy

  def participant_names
    conversation_participants.map(&:user).map(&:login)
  end
end
