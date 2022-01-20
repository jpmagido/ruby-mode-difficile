# frozen_string_literal: true

module Login
  class CoachesController < Login::BaseController
    def new
      @new_coach = Coach.new
    end

    def create
      @new_coach = Coach.create!(user_id: current_user.id)
      conversation.ask_coach_promotion(current_user.id)
      flash[:success] = t('coaches.flashes.create-success')
      redirect_to root_path
    end

    private

    def conversation
      ::ConversationManager.new(admins + [current_user]).find_conversation
    end

    def admins
      User.joins(:admin)
    end
  end
end
