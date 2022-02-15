# frozen_string_literal: true

module Login
  class ConversationMessagesController < Login::BaseController
    helper_method :conversation

    def new
      @conversation_message = conversation.conversation_messages.new
    end

    def create
      @conversation_message = conversation.conversation_messages.new(
        conversation_participant_id: current_participant.id,
        content: conversation_message_params[:content]
      )
      if @conversation_message.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to login_conversation_path(conversation) }
        end
      else
        respond_to do |format|
          format.html do
            flash.now[:error] = t('conversations.flashes.error', error: new_message.errors.messages)
            render 'login/conversations/show'
          end
        end
      end
    end

    private

    def conversation
      @conversation ||= Conversation.find(params[:conversation_id])
    end

    def current_participant
      @current_participant ||= conversation.conversation_participants.find_by(user_id: current_user.id)
    end

    def conversation_message_params
      params.require(:conversation_message).permit(:content)
    end
  end
end
