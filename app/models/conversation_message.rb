# frozen_string_literal: true

class ConversationMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :conversation_participant

  has_rich_text :content
end
