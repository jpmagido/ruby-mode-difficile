# frozen_string_literal: true

module Mentor
  class BaseController < ApplicationController
    before_action :authenticate_mentor!

    private

    def authenticate_mentor!
      unless current_user.coach
        flash[:error] = t('mentor.users.flashes.authenticate-mentor')
        redirect_to new_login_coach_path
      end
    end
  end
end
