# frozen_string_literal: true

module Academy
  class TimeSlotsController < Academy::BaseController
    helper_method :time_slots, :mentorship_session

    def update
      authorize time_slot

      respond_to do |format|
        if time_slot.update(time_slot_params)
          format.html do
            format.turbo_stream
            flash[:success] = t('academy.time_slots.flashes.success-update')
            redirect_to academy_mentorship_session_path mentorship_session
          end
        else
          format.html do
            flash[:error] = t('shared.errors.update', error: time_slot.errors.messages)
            redirect_to academy_mentorship_session_path mentorship_session
          end
        end
      end
    end

    private

    def mentorship_session
      @mentorship_session ||= MentorshipSession.find(params[:mentorship_session_id])
    end

    def time_slots
      @time_slots ||= mentorship_session.time_slots
    end

    def time_slot
      @time_slot ||= time_slots.find(params[:id])
    end

    def time_slot_params
      params.require(:time_slot).permit(:student_approval)
    end
  end
end
