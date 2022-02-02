# frozen_string_literal: true

module Login
  class MentorshipsController < Login::BaseController
    helper_method :mentorships, :mentorship

    def create
      @new_mentorship = current_user.student.mentorships.new(coach_id: params[:coach_id], student_approval: true)
      if @new_mentorship.save
        flash[:success] = t('login.mentorships.flashes.create-success')
        redirect_to login_mentorship_path(@new_mentorship)
      else
        flash[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        redirect_to login_mentorship_path(@new_mentorship)
      end
    end

    def update
      if mentorship.update(mentorships_params)
        flash[:success] = t('mentor.mentorships.flashes.update-success')
        redirect_to login_mentorship_path(mentorship)
      else
        flash.now[:error] = t('mentor.mentorships.flashes.error', error: @new_mentorship.errors.messages)
        render 'login/mentorships/edit'
      end
    end

    private

    def mentorships
      @mentorships ||= current_user.student.mentorships
    end

    def mentorship
      @mentorship ||= mentorships.find(params[:id])
    end

    def mentorships_params
      params.require(:mentorship).permit(:student_approval)
    end
  end
end
