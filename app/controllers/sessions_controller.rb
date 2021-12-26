# frozen_string_literal: true

# TODO: rspec
class SessionsController < ApplicationController
  rescue_from UnsafeRedirectError, Github::Api::RequestError, HttpService::RequestError, with: :oauth_error

  def create
    case Rails.env
    when 'development'
      res = Github::Oauth.new(username: ENV['GITHUB_PERSONAL_TOKEN']).oauth_development
      parsed_response = JSON.parse res.body
      # TODO: update session + find / create User
      flash[:success] = t('session.success.oauth')
      redirect_to session_path
    when 'production'
      redirect_to Github::Oauth::GITHUB_OAUTH_AUTHORIZE_URL, authorize_params
    else
      raise UnsafeRedirectError, t('session.errors.unsafe-redirect', rails_env: Rails.env)
    end
  end

  def temp_oauth
    sleep(5)
    p '*' * 50
    p 'inside temp github'
    p params
    p '*' * 50
    # to debug params
    code = { code: params[:code] }
    check_validity!(params[:state])
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
      login: 'ruby-master',
      scope: nil,
      state: secure_random,
      allow_signup: 'true'
    }
  end

  def check_validity!(state)
    p '*' * 50
    p 'state inside check_validity'
    p state
    p '*' * 50
    raise UnsafeRedirectError, t('session.errors.safe-state') if state != secure_random
  end

  def secure_random
    @secure_random ||= SecureRandom.hex(10)
  end

  def oauth_error(err)
    flash[:error] = err
    redirect_to new_session_path
  end
end
