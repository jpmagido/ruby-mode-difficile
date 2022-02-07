# frozen_string_literal: true

module Mentor
  class TimeSlotsController < Mentor::BaseController
    helper_method :time_slots

    private

    def mentorship_session
      @mentorship_session ||= MentorshipSession.find(params[:mentorship_session_id])
    end

    def time_slots
      @time_slots ||= mentorship_session.time_slots
    end
  end
end
