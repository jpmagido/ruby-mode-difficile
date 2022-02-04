# frozen_string_literal: true

module Mentor
  class CoachesController < Mentor::BaseController
    helper_method :coach

    def update
      if coach.update coach_params
        flash[:success] = t('coaches.flashes.update-success')
        redirect_to mentor_coach_path
      else
        flash.now[:error] = t('shared.errors.update', error: coach.errors.messages)
        render 'mentor/coaches/edit'
      end
    end

    private

    def coach
      @coach ||= current_user.coach
    end

    def coach_params
      params.require(:coach).permit(:description)
    end
  end
end
