# frozen_string_literal: true

# TODO: rspec
class SessionsController < ApplicationController
  rescue_from UnsafeRedirectError, Github::Api::RequestError, HttpService::RequestError, with: :oauth_error

  def new
    if Rails.env == 'production'
      @github_oauth_url = HttpService.new(Github::Oauth::GITHUB_OAUTH_AUTHORIZE_URL, authorize_params).build_url
    end
  end

  def create
    raise UnsafeRedirectError, t('session.errors.unsafe-redirect', rails_env: Rails.env) if Rails.env != 'development'

    res = Github::Oauth.new(username: ENV['GITHUB_PERSONAL_TOKEN']).oauth_development
    parsed_response = JSON.parse res.body
    # TODO: update session + find / create User
    flash[:success] = t('session.success.oauth')
    redirect_to session_path
  end

  def temp_oauth
    p '*' * 50
    p 'params'
    p params

    p 'secure_random'
    p secure_random
    p 'params[:state]'
    p params[:state]
    p "params['state']"
    p params['state']
    p '*' * 50
    raise UnsafeRedirectError, t('session.errors.safe-state') unless params[:state] == secure_random

    code = { code: params[:code] }
    response = Github::Oauth.new(access_token_params.merge(code)).oauth_production

    p '*' * 50
    p 'github token response'
    p response
    p '*' * 50

    # TODO: update session + create / find User
    # token = response.split('=')[1]
    # github_user = GithubApi.new(token).find_user

    flash[:success] = t('session.success.oauth')
    redirect_to session_path
  end

  private

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

  def oauth_error(err)
    flash[:error] = err
    redirect_to new_session_path
  end
end
