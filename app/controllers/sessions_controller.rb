# frozen_string_literal: true

# TODO: rspec
class SessionsController < ApplicationController
  # rescue_from UnsafeRedirectError, Github::Api::RequestError, HttpService::RequestError, with: :standard_errors

  def new
    if Rails.env.production?
      @github_oauth_url = Github::Oauth.new(state: secure_random).step_1
    end
  end

  def create
    raise UnsafeRedirectError, t('session.errors.unsafe-redirect', rails_env: Rails.env) if Rails.env.production?

    sync_user_session(ENV['GITHUB_PERSONAL_TOKEN'])

    flash[:success] = t('session.success.oauth')
    redirect_to login_user_path
  end

  def edit
    raise UnsafeRedirectError, t('session.errors.safe-state') unless params[:state] == secure_random

    response = Github::Oauth.new(code: params[:code]).step_2
    response_data = Rack::Utils.parse_nested_query(response.body)
    sync_user_session(response_data['access_token'])

    flash[:success] = t('session.success.oauth')
    redirect_to login_user_path
  end

  def destroy
    flash[:notice] = t('session.destroy.disconnect') if current_user.session.destroy

    session[:user_session_id] = nil
    redirect_to root_path
  end

  private

  def sync_user_session(access_token)
    session[:user_session_id] = Github::Sync::UserSession.new(access_token, request).save_session!
  end

  def authorize_params
    {

      state: secure_random,
    }
  end

  def secure_random
    @secure_random ||= ENV['GITHUB_REDIRECT_TOKEN']
  end
end
