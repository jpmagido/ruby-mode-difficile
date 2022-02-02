# frozen_string_literal: true

class ConversationManager
  attr_reader :users

  def initialize(user_array)
    raise ArgumentError unless user_array.is_a? Array

    @users = user_array.uniq
  end

  def find_conversation
    potential_conversations = users.sample
                                   .conversations
                                   .select { |c| c.conversation_participants.map(&:user_id).to_set == user_ids.to_set }
                                   .uniq

    raise DuplicatedConversation, potential_conversations if potential_conversations.count > 1

    potential_conversations.empty? ? create_conversation : potential_conversations.first
  end

  private

  def create_conversation
    ActiveRecord::Base.transaction do
      conversation = Conversation.create!
      user_ids.each { |user_id| conversation.conversation_participants.create!(user_id: user_id) }

      conversation
    end
  end

  def user_ids
    users.map(&:id)
  end

  class DuplicatedConversation < StandardError; end
end
