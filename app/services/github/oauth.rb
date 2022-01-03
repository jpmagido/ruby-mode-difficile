# frozen_string_literal: true

module Github
  class Oauth
    LOG_USER_URL = 'https://api.github.com/user'
    AUTHORIZE_URL = 'https://github.com/login/oauth/authorize'
    GITHUB_OAUTH_TOKEN_URL = 'https://github.com/login/oauth/access_token'

    attr_reader :params

    def initialize(params = {})
      @params = params

      raise ArgumentError, 'Username is required in params' unless params[:username]
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
