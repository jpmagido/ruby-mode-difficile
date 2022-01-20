# frozen_string_literal: true

class ConversationManager
  attr_reader :users

  def initialize(user_array)
    raise ArgumentError unless user_array.is_a? Array

    @users = user_array
  end

  def find_conversation
    potential_conversations = users.sample.conversations.select { |c| c.conversation_participants.count == user_count }

    return create_conversation if potential_conversations.empty?

    conversation = potential_conversations.detect { |c| c.conversation_participant_ids.to_set == user_ids.to_set }

    conversation || create_conversation
  end

  private

  def create_conversation
    ActiveRecord::Base.transaction do
      conversation = Conversation.create!
      users.each { |user| conversation.conversation_participants.create!(user_id: user.id) }

      conversation
    end
  end

  def user_count
    users.count
  end

  def user_ids
    users.map(&:id)
  end
end
