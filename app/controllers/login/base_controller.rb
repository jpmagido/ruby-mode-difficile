# frozen_string_literal: true

module Login
  class BaseController < ApplicationController
    before_action :authenticate_user!

    private

    def authenticate_user!
      unless current_user
        flash[:error] = t('session.redirect.login')
        redirect_to new_session_path
      end
    end
  end
end
