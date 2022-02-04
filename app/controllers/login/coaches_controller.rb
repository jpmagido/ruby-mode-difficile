# frozen_string_literal: true

module Login
  class CoachesController < Login::BaseController
    def new
      @new_coach = Coach.new
    end

    def create
      @new_coach = Coach.new(user_id: current_user.id)
      authorize @new_coach

      @new_coach.save!
      messages_to_send.each { |msg| conversation.send_message(current_user.id, msg) }

      flash[:success] = t('coaches.flashes.create-success')
      redirect_to login_conversation_path(conversation)
    end

    private

    def conversation
      @conversation ||= ::ConversationManager.new(admins + [current_user]).find_conversation
    end

    def messages_to_send
      [
        t('coaches.messages.admin-promotion', user_path: helpers.link_to('page', current_user.admin_page)),
        params[:coach][:message]
      ]
    end
  end
end
