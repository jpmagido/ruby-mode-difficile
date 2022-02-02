# frozen_string_literal: true

class ConversationPolicy < AppPolicy
  def show?
    belongs_to_conversation?
  end

  def create?
    belongs_to_conversation?
  end

  private

  def belongs_to_conversation?
    record.conversation_participants.map(&:user_id).include? user.id
  end
end
