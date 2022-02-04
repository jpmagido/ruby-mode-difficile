# frozen_string_literal: true

module Staff
  class MentorshipsController < Staff::BaseController
    helper_method :mentorships, :mentorship

    private

    def mentorships
      @mentorships ||= Mentorship.all
    end

    def mentorship
      @mentorship ||= mentorships.find(params[:id])
    end
  end
end
