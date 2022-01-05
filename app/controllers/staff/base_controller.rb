# frozen_string_literal: true

module Staff
  class BaseController < ApplicationController
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      unless current_user&.admin
        flash[:error] = t('admins.flashes.admin-status')
        redirect_to root_path
      end
    end
  end
end
