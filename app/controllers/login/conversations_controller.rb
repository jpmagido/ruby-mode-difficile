# frozen_string_literal: true

module Login
  class ConversationsController < Login::BaseController
    layout 'conversation'

    helper_method :conversation, :conversation_messages

    def show
      authorize conversation if conversation
    end

    private

    def conversation
      @conversation ||= Conversation.find_by(id: params[:id])
    end

    def conversation_messages
      @conversation_messages ||= conversation.conversation_messages.order(created_at: :asc)
    end
  end
end
