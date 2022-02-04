# frozen_string_literal: true

module Academy
  class StudentsController < Academy::BaseController
    helper_method :student

    def show
      authorize student
    end

    def update
      authorize student

      if student.update(student_params)
        flash[:success] = t('academy.students.flashes.success.update')
        redirect_to academy_student_path(student)
      else
        flash.now[:error] = t('shared.errors.update', error: student.errors.messages)
        render 'academy/students/edit'
      end
    end

    private

    def student
      @student ||= current_user.student
    end

    def student_params
      params.require(:student).permit(:description, :status)
    end
  end
end
