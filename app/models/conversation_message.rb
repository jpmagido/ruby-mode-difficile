# frozen_string_literal: true

class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :conversation_participant

  after_create_commit lambda {
    broadcast_append_to conversation,
                        partial: 'login/conversation_messages/conversation_message',
                        locals: { current_user: conversation_participant.user }
  }

  has_rich_text :content

  def author?(user_id)
    conversation_participant&.user_id == user_id
  end
end
