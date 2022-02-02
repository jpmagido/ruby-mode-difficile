# frozen_string_literal: true

module Login
  class ConversationsController < Login::BaseController
    layout 'conversation'

    helper_method :conversation

    def show
      if conversation
        authorize conversation
        @new_message = conversation.conversation_messages.new
      end
    end

    # create message in current conversation
    def create
      current_conversation = Conversation.find(conversation_params[:conversation_id])
      authorize current_conversation

      current_participant = current_conversation.conversation_participants.find_by(user_id: current_user.id)

      new_message = current_conversation.conversation_messages.new(
        conversation_participant_id: current_participant.id,
        content: conversation_params[:content]
      )

      if new_message.save
        redirect_to login_conversation_path(current_conversation)
      else
        flash.now[:error] = t('conversations.flashes.error', error: new_message.errors.messages)
        render 'login/conversations/show'
      end
    end

    private

    def conversation
      @conversation ||= Conversation.find_by(id: params[:id])
    end

    def conversation_params
      params.permit(:content, :conversation_id)
    end
  end
end
