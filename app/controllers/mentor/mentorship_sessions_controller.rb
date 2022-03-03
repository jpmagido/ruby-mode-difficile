# frozen_string_literal: true

module Mentor
  class MentorshipSessionsController < Mentor::BaseController
    helper_method :mentorship_sessions, :mentorship_session, :calendar_hash

    def new
      @new_mentorship_session = MentorshipSession.new
      authorize @new_mentorship_session
    end

    def create
      @new_mentorship_session = MentorshipSession.new(mentorship_session_params)
      authorize @new_mentorship_session

      if @new_mentorship_session.save
        conversation(@new_mentorship_session).send_message(
          current_user,
          t('mentor.mentorship_sessions.messages.coach-create', date: @new_mentorship_session.start_date, url: @new_mentorship_session.show_page)
        )

        flash[:success] = t('mentor.mentorship_sessions.flashes.success-create')
        redirect_to mentor_mentorship_session_path(@new_mentorship_session)
      else
        flash.now[:error] = t('shared.errors.create', error: @new_mentorship_session.errors.messages)
        render 'mentor/mentorship_sessions/new'
      end
    end

    def update
      authorize mentorship_session

      if mentorship_session.update(mentorship_session_params)
        conversation(mentorship_session).send_message(
          current_user,
          t('mentor.mentorship_sessions.messages.coach-update', date: mentorship_session.start_date, url: mentorship_session.show_page)
        )

        flash[:success] = t('mentor.mentorship_sessions.flashes.success-update')
        redirect_to mentor_mentorship_sessions_path
      else
        flash.now[:error] = t('shared.errors.update', error: mentorship_session.errors.messages)
        render 'mentor/mentorship_sessions/edit'
      end
    end

    def destroy
      authorize mentorship_session

      if mentorship_session.destroy
        conversation(mentorship_session).send_message(
          current_user,
          t('mentor.mentorship_sessions.messages.coach-update', date: mentorship_session.start_date)
        )

        flash[:success] = t('mentor.mentorship_sessions.flashes.success-destroy')
        redirect_to mentor_coach_path(current_user.coach)
      else
        flash[:error] = t('shared.errors.destroy', error: mentorship_session.errors.messages)
        redirect_to mentor_mentorship_session_path(mentorship_session)
      end
    end

    private

    def mentorship_sessions
      @mentorship_sessions ||= Search::MentorshipSession.new(current_user.coach.mentorship_sessions, search_params).search
    end

    def mentorship_session
      @mentorship_session ||= mentorship_sessions.find(params[:id])
    end

    def mentorship_session_params
      params.require(:mentorship_session).permit(:start_date, :end_date, :mentorship_id)
    end

    def conversation(mentorship_session)
      @conversation ||= ConversationManager.new([current_user, mentorship_session.mentorship.student.user]).find_conversation
    end

    def calendar_hash
      {
        attribute: :start_date,
        events: mentorship_session.time_slots,
        start_date: mentorship_session.start_date,
        number_of_days: mentorship_session.duration
      }
    end

    def search_params
      params.permit(
        :start_date,
        :end_date,
        :incoming
      )
    end
  end
end
