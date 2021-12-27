# frozen_string_literal: true

# TODO: rspec
class SessionsController < ApplicationController
  #rescue_from UnsafeRedirectError, Github::Api::RequestError, HttpService::RequestError, with: :standard_errors

  def new
    if Rails.env.production?
      @github_oauth_url = HttpService.new(Github::Oauth::AUTHORIZE_URL, authorize_params).build_url
    end
  end

  def create
    raise UnsafeRedirectError, t('session.errors.unsafe-redirect', rails_env: Rails.env) unless Rails.env.development?

    sync_user_session(ENV['GITHUB_PERSONAL_TOKEN'])

    flash[:success] = t('session.success.oauth')
    redirect_to session_path
  end

  def temp_oauth
    raise UnsafeRedirectError, t('session.errors.safe-state') unless params[:state] == secure_random

    code = { code: params[:code] }
    response = Github::Oauth.new(access_token_params.merge(code)).oauth_production

    response_data = Rack::Utils.parse_nested_query(response.body)
    sync_user_session(response_data['access_token'])

    flash[:success] = t('session.success.oauth')
    redirect_to session_path
  end

  private

  def sync_user_session(access_token)
    github_user = Github::Api.new(access_token).find_user
    user = Github::Sync::User.new(github_user).synced_user

    ActiveRecord::Base.transaction do
      user.save!
      user_session = Github::Sync::Session.new(github_user, request, access_token).build
      user_session.save!
    end
    # TODO: UPDATE Rails session with user.session.id
  end

  def access_token_params
    {
      client_id: ENV['GITHUB_OAUTH_CLIENT_ID'],
      client_secret: ENV['GITHUB_OAUTH_SECRET'],
      redirect_uri: nil
    }
  end

  def authorize_params
    {
      client_id: ENV['GITHUB_OAUTH_CLIENT_ID'],
      redirect_uri: nil,
      login: 'login',
      scope: nil,
      state: secure_random,
      allow_signup: 'true'
    }
  end

  def secure_random
    @secure_random ||= ENV['GITHUB_REDIRECT_TOKEN']
  end
end
