# frozen_string_literal: true

module Mentor
  class StudentsController < Mentor::BaseController
    helper_method :students, :student, :conversation

    private

    def students
      @students ||= Student.all
    end

    def student
      @student ||= students.find(params[:id])
    end

    def conversation
      @conversation ||= ConversationManager.new([current_user, student.user]).find_conversation
    end
  end
end
