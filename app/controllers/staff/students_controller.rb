# frozen_string_literal: true

module Staff
  class StudentsController < Staff::BaseController
    helper_method :students, :student

    def show
      authorize student, policy_class: AdminPolicy
    end

    def edit
      authorize student, policy_class: AdminPolicy
    end

    def update
      authorize student, policy_class: AdminPolicy

      if student.update(student_params)
        conversation.send_message(student.user_id, message_to_student)
        flash[:success] = t('students.flashes.create-success')
        redirect_to staff_student_path(student)
      else
        flash.new[:error] = t('shared.errors.create', error: student.errors.messages)
        render 'staff/students/edit'
      end
    end

    private

    def students
      @students = Student.all
    end

    def student
      @student ||= students.find(params[:id])
    end

    def conversation
      @conversation ||= ::ConversationManager.new(admins + [student.user]).find_conversation
    end

    def message_to_student
      t('staff.students.messages.status', status: student.status)
    end

    def student_params
      params.require(:student).permit(:status, :description)
    end
  end
end
