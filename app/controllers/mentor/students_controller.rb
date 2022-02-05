# frozen_string_literal: true

module Mentor
  class StudentsController < Mentor::BaseController
    helper_method :students, :student, :conversation

    private

    def students
      @students ||= Search::Student.new(available_students, search_params).search
    end

    def student
      @student ||= available_students.find(params[:id])
    end

    def available_students
      @available_students ||= Student.ready
    end

    def conversation
      @conversation ||= ConversationManager.new([current_user, student.user]).find_conversation
    end

    def search_params
      params.permit(
        :name,
        :challenge_count_min,
        :challenge_count_max,
        :has_coach,
        :language
      )
    end
  end
end
