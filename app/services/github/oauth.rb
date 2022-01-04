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

    def oauth_production
      HttpService.new(GITHUB_OAUTH_TOKEN_URL, params).post
    end
  end
end
