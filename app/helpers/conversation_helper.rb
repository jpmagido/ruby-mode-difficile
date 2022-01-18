# frozen_string_literal: true

module ConversationHelper
  def active_conv?(current_conv, conversation_id)
    current_conv == conversation_id ? 'active' : ''
  end

  def message_author?(message, user_id)
    message.author?(user_id) ? 'my' : 'his'
  end
end
