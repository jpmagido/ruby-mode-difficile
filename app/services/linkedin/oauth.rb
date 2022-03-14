# frozen_string_literal: true

module Linkedin
  class Oauth
    attr_reader :params

    AUTHORIZE_URL = 'https://www.linkedin.com/oauth/v2/authorization'
    ACCESS_TOKEN_URL = 'https://www.linkedin.com/oauth/v2/accessToken'

    def initialize(params = {})
      @params = params

      raise ArgumentError, 'params must be a Hash' unless params.is_a? Hash
    end

    def step_1
      HttpService.new(AUTHORIZE_URL, authorize_params).build_url
    end

    def step_2
      HttpService.new(ACCESS_TOKEN_URL, access_token_params, step2_headers).post
    end

    private

    def authorize_params
      params.merge(
        response_type: 'code',
        client_id: ENV['LINKEDIN_CLIENT_ID'],
        redirect_uri: redirect_uri,
        scope: 'r_liteprofile'
      )
    end

    def access_token_params
      params.merge(
        grant_type: 'authorization_code',
        client_id: ENV['LINKEDIN_CLIENT_ID'],
        client_secret: ENV['LINKEDIN_CLIENT_SECRET'],
        redirect_uri: redirect_uri
      )
    end

    def redirect_uri
      if Rails.env.production?
        'https://ruby-mode-difficile.herokuapp.com/linkedin_session/edit'
      else
        'http://localhost:3000/linkedin_session/edit'
      end
    end

    def step2_headers
      { 'Content-Type': 'x-www-form-urlencoded' }
    end
  end
end