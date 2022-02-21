# frozen_string_literal: true

module Staff
  class MentorshipSessionsController < Staff::BaseController
    helper_method :mentorship_sessions, :mentorship_session, :calendar_hash

    private

    def mentorship_sessions
      @mentorship_sessions ||= MentorshipSession.all
    end

    def mentorship_session
      mentorship_sessions.find(params[:id])
    end

    def calendar_hash
      {
        attribute: :start_date,
        events: mentorship_session.time_slots,
        start_date: mentorship_session.start_date,
        number_of_days: mentorship_session.duration
      }
    end
  end
end
