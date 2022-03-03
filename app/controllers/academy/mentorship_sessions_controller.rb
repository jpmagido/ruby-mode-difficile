# frozen_string_literal: true

module Academy
  class MentorshipSessionsController < Academy::BaseController
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
          t('academy.mentorship_sessions.messages.student-create', date: @new_mentorship_session.start_date, url: @new_mentorship_session.show_page)
        )

        flash[:success] = t('mentor.mentorship_sessions.flashes.success-create')
        redirect_to academy_mentorship_session_path(@new_mentorship_session)
      else
        flash.now[:error] = t('shared.errors.create', error: @new_mentorship_session.errors.messages)
        render 'academy/mentorship_sessions/new'
      end
    end

    def update
      authorize mentorship_session

      if mentorship_session.update(mentorship_session_params)
        conversation(mentorship_session).send_message(
          current_user,
          t('academy.mentorship_sessions.messages.student-update', date: mentorship_session.start_date, url: mentorship_session.show_page)
        )

        flash[:success] = t('mentor.mentorship_sessions.flashes.success-update')
        redirect_to academy_mentorship_session_path(mentorship_session)
      else
        flash.now[:error] = t('shared.errors.update', error: mentorship_session.errors.messages)
        render 'academy/mentorship_sessions/edit'
      end
    end

    def destroy
      authorize mentorship_session
      conversation(mentorship_session).send_message(current_user, t('academy.mentorship_sessions.messages.student-destroy', date: mentorship_session.start_date))

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
      @mentorship_sessions ||= Search::MentorshipSession.new(current_user.student.mentorship_sessions, search_params).search
    end

    def mentorship_session
      @mentorship_session ||= mentorship_sessions.find(params[:id])
    end

    def mentorship_session_params
      params.require(:mentorship_session).permit(:start_date, :end_date, :mentorship_id)
    end

    def conversation(mentorship_session)
      @conversation ||= ConversationManager.new([current_user, mentorship_session.mentorship.coach.user]).find_conversation
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
