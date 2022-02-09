# frozen_string_literal: true

module Academy
  class TimeSlotsController < Academy::BaseController
    helper_method :time_slots, :mentorship_session

    def update
      if time_slot.update(student_approval: params[:student_approval])
        flash[:success] = t('academy.time_slots.flashes.success-update')
      else
        flash[:error] = t('shared.errors.update', error: time_slot.errors.messages)
      end
      redirect_to academy_mentorship_session_path mentorship_session
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
  end
end
