# frozen_string_literal: true

class ConversationParticipant < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  has_many :conversation_messages, dependent: :destroy
end
