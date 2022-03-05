# frozen_string_literal: true

module Github
  class Oauth
    AUTHORIZE_URL = 'https://github.com/login/oauth/authorize'
    GITHUB_OAUTH_TOKEN_URL = 'https://github.com/login/oauth/access_token'

    attr_reader :params

    def initialize(params = {})
      @params = params

      raise ArgumentError, 'params must be a Hash' unless params.is_a? Hash
    end

    def step_1
      HttpService.new(AUTHORIZE_URL, step1_params).build_url
    end

    def step_2
      HttpService.new(GITHUB_OAUTH_TOKEN_URL, step2_params).post
    end

    private

    def step2_params
      params.merge(
        client_id: ENV['GITHUB_OAUTH_CLIENT_ID'],
        client_secret: ENV['GITHUB_OAUTH_SECRET'],
        redirect_uri: nil
      )
    end

    def step1_params
      params.merge(
        client_id: ENV['GITHUB_OAUTH_CLIENT_ID'],
        redirect_uri: nil,
        login: 'login',
        scope: nil,
        allow_signup: 'true'
      )
    end
  end
end
