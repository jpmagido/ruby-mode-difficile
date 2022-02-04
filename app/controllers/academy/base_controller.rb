# frozen_string_literal: true

module Academy
  class BaseController < ApplicationController
    before_action :authenticate_student!

    private

    def authenticate_student!
      unless current_user.student&.ready?
        flash[:error] = t('academy.students.flashes.unauthorized')
        redirect_to new_login_student_path
      end
    end
  end
end
