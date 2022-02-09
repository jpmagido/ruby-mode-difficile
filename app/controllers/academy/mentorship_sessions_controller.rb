# frozen_string_literal: true

module Academy
  class MentorshipSessionsController < Academy::BaseController
    helper_method :mentorship_sessions, :mentorship_session, :calendar_hash

    def new
      @new_mentorship_session = MentorshipSession.new
    end

    def create
      @new_mentorship_session = MentorshipSession.new(mentorship_session_params)

      if @new_mentorship_session.save
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-create')
        redirect_to academy_mentorship_session_path(@new_mentorship_session)
      else
        flash.now[:error] = t('shared.errors.create', error: @new_mentorship_session.errors.messages)
        render 'academy/mentorship_sessions/new'
      end
    end

    def update
      if mentorship_session.update(mentorship_session_params)
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-update')
        redirect_to academy_mentorship_session_path(mentorship_session)
      else
        flash.now[:error] = t('shared.errors.update', error: mentorship_session.errors.messages)
        render 'academy/mentorship_sessions/edit'
      end
    end

    def destroy
      if mentorship_session.destroy
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-destroy')
        redirect_to academy_student_path(current_user.student)
      else
        flash[:error] = t('shared.errors.destroy', error: mentorship_session.errors.messages)
        redirect_to academy_mentorship_session_path(mentorship_session)
      end
    end

    private

    def mentorship_sessions
      @mentorship_sessions ||= current_user.student.mentorship_sessions
    end

    def mentorship_session
      @mentorship_session ||= mentorship_sessions.find(params[:id])
    end

    def mentorship_session_params
      params.require(:mentorship_session).permit(:start_date, :end_date, :mentorship_id)
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
