# frozen_string_literal: true

module Academy
  class MentorshipsController < Academy::BaseController
    helper_method :mentorships, :mentorship

    def create
      @new_mentorship = current_user.student.mentorships.new(coach_id: params[:coach_id], student_approval: true)
      authorize @new_mentorship

      if @new_mentorship.save
        conversation(@new_mentorship).send_message(current_user, t('academy.mentorships.messages.student-create'))

        flash[:success] = t('login.mentorships.flashes.create-success')
        redirect_to academy_mentorship_path(@new_mentorship)
      else
        flash[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        redirect_to academy_mentorship_path(@new_mentorship)
      end
    end

    def update
      authorize mentorship

      if mentorship.update(mentorships_params)
        conversation(mentorship).send_message(current_user, t('academy.mentorships.messages.student-update'))

        flash[:success] = t('mentor.mentorships.flashes.update-success')
        redirect_to academy_mentorship_path(mentorship)
      else
        flash.now[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        render 'academy/mentorships/edit'
      end
    end

    private

    def mentorships
      @mentorships ||= current_user.student.mentorships
    end

    def mentorship
      @mentorship ||= mentorships.find(params[:id])
    end

    def conversation(mentorship)
      @conversation ||= ConversationManager.new([current_user, mentorship.coach.user]).find_conversation
    end

    def mentorships_params
      params.require(:mentorship).permit(:student_approval)
    end
  end
end
