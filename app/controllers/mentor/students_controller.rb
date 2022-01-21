# frozen_string_literal: true

module Mentor
  class StudentsController < Mentor::BaseController
    helper_method :students, :student

    private

    def students
      @students ||= Student.all
    end

    def student
      @student ||= students.find(params[:id])
    end
  end
end
