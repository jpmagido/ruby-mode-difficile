# frozen_string_literal: true

module Login
  class StudentsController < Login::BaseController
    def new
      @new_student = Student.new
    end

    def create
      @new_student = Student.new student_params.merge(user_id: current_user.id)

      if @new_student.save
        messages.each { |msg| conversation.send_message(current_user.id, msg) }

        flash[:success] = t('students.flashes.create-success')
        redirect_to academy_student_path(current_user.student)
      else
        flash.now[:error] = t('shared.errors.create', error: @new_student.errors.messages)
        render 'login/students/new'
      end
    end

    private

    def conversation
      @conversation ||= ::ConversationManager.new(admins + [current_user]).find_conversation
    end

    def messages
      [
        t('students.new-student-admin', user_path: helpers.link_to('page', current_user.admin_page)),
        student_params[:description]
      ]
    end

    def student_params
      params.require(:student).permit(:description)
    end
  end
end
