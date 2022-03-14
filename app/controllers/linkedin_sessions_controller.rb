# frozen_string_literal: true

class LinkedinSessionsController < ApplicationController
  def new
    @oauth_link = Linkedin::Oauth.new(state: secure_random).step_1
  end

  def edit
    raise UnsafeRedirectError, t('session.errors.safe-state') unless params[:state] == secure_random

    if Linkedin::Sync::LinkedinSession.new(current_user, linkedin_token).sync
      flash[:success] = t('linkedin_sessions.flashes.success')
      redirect_to login_user_path
    else
      flash[:error] = t('linkedin_sessions.flashes.error')
      redirect_to new_linkedin_session_path
    end
  end

  private

  def linkedin_token
    JSON.parse(Linkedin::Oauth.new(code: params[:code]).step_2.body)['access_token']
  end

  def secure_random
    @secure_random ||= ENV['LINKEDIN_REDIRECT_TOKEN']
  end
end
