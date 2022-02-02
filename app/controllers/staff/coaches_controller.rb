# frozen_string_literal: true

module Staff
  class CoachesController < Staff::BaseController
    helper_method :coaches, :coach

    def update
      if coach.update(coach_params)
        flash[:success] = t('staff.coaches.flashes.update-success')
        redirect_to staff_coach_path(coach)
      else
        flash.now[:error] = t('staff.coaches.flashes.error', error: coach.errors.messages)
        render 'staff/coaches/edit'
      end
    end

    private

    def coaches
      @coaches ||= Coach.all
    end

    def coach
      @coach ||= coaches.find(params[:id])
    end

    def coach_params
      params.require(:coach).permit(:status)
    end
  end
end
