# frozen_string_literal: true

class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :conversation_participant

  has_rich_text :content

  def author?(user_id)
    conversation_participant&.user_id == user_id
  end
end
