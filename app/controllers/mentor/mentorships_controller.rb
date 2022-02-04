# frozen_string_literal: true

module Mentor
  class MentorshipsController < Mentor::BaseController
    helper_method :mentorships, :mentorship

    def create
      @new_mentorship = current_user.coach.mentorships.new(student_id: params[:student_id], coach_approval: true)
      if @new_mentorship.save
        conversation.send_message(current_user, create_mentorship_message(@new_mentorship))

        flash[:success] = t('mentor.mentorships.flashes.create-success')
        redirect_to mentor_mentorship_path(@new_mentorship)
      else
        flash[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        redirect_to mentor_student_path(params[:student_id])
      end
    end

    def update
      if mentorship.update(mentorships_params)
        conversation.send_message(current_user, update_mentorship_message(mentorship))

        flash[:success] = t('mentor.mentorships.flashes.update-success')
        redirect_to mentor_mentorship_path(mentorship)
      else
        flash.now[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        render 'mentor/mentorships/edit'
      end
    end

    private

    def mentorships
      @mentorships ||= current_user.coach.mentorships.order(:created_at)
    end

    def mentorship
      @mentorship ||= mentorships.find(params[:id])
    end

    def conversation
      @conversation ||= ConversationManager.new([current_user, student.user]).find_conversation
    end

    def student
      @student ||= Student.find_by(id: params[:student_id]) || mentorship.student
    end

    def create_mentorship_message(mentorship)
      t('mentor.mentorships.send-student-message',
        mentorship_path: "#{mentorship.show_page_student} // #{mentorship.show_page_coach}"
      )
    end

    def update_mentorship_message(mentorship)
      t('mentor.mentorships.update-mentorship-message',
        mentorship_path: "#{mentorship.show_page_student} // #{mentorship.show_page_coach}"
      )
    end

    def mentorships_params
      params.require(:mentorship).permit(:coach_approval)
    end
  end
end
