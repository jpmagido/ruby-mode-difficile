# frozen_string_literal: true

# TODO: rspec
module Github
  class Oauth
    LOG_USER_URL = 'https://api.github.com/user'
    GITHUB_OAUTH_AUTHORIZE_URL = 'https://github.com/login/github/authorize'
    GITHUB_OAUTH_TOKEN_URL = 'https://github.com/login/github/access_token'

    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def oauth_development
      HttpService.new(LOG_USER_URL, {}, headers).get
    end

    def oauth_production
      HttpService.new(GITHUB_OAUTH_TOKEN_URL, params).post
    end

    private

    def headers
      {
        'Authorization': "token #{params[:username]}"
      }
    end
  end
end
