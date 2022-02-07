# frozen_string_literal: true

module Mentor
  class MentorshipSessionsController < Mentor::BaseController
    helper_method :mentorship_sessions, :mentorship_session

    def new
      @new_mentorship_session = MentorshipSession.new
    end

    def create
      @new_mentorship_session = MentorshipSession.new(mentorship_session_params)

      if @new_mentorship_session.save
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-create')
        redirect_to mentor_mentorship_session_time_slots_path(@new_mentorship_session)
      else
        flash.now[:error] = t('shared.errors.create', error: @new_mentorship_session.errors.messages)
        render 'mentor/mentorship_sessions/new'
      end
    end

    def update
      if mentorship_session.update(mentorship_session_params)
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-update')
        redirect_to mentor_mentorship_session_path(mentorship_session)
      else
        flash.now[:error] = t('shared.errors.update', error: mentorship_session.errors.messages)
        render 'mentor/mentorship_sessions/edit'
      end
    end

    def destroy
      if mentorship_session.destroy
        flash[:success] = t('mentor.mentorship_sessions.flashes.success-destroy')
        redirect_to mentor_coach_path(current_user.coach)
      else
        flash[:error] = t('shared.errors.destroy', error: mentorship_session.errors.messages)
        redirect_to mentor_mentorship_session_path(mentorship_session)
      end
    end

    private

    def mentorship_sessions
      @mentorship_sessions ||= current_user.coach.mentorship_sessions
    end

    def mentorship_session
      @mentorship_session ||= mentorship_sessions.find(params[:id])
    end

    def mentorship_session_params
      params.require(:mentorship_session).permit(:start_date, :end_date, :mentorship_id)
    end
  end
end
