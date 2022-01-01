# frozen_string_literal: true

module Login
  class BaseController < ApplicationController
    before_action :authenticate_user!

    protected

    def to_login
      flash[:notice] = t('session.redirect.login')
      redirect_to new_session_path
    end

    private

    def authenticate_user!
      flash[:error] = t('session.redirect.login')
      redirect_to new_session_path unless current_user
    end
  end
end
