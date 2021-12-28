# frozen_string_literal: true

require 'net/http'
require 'uri'

# TODO: rspec
module Github
  class Api
    attr_reader :token

    GET_USER_URL = 'https://api.github.com/user'

    def initialize(token)
      @token = token

      raise ArgumentError, 'token must be present' unless token
    end

    def find_user
      response = HttpService.new(GET_USER_URL, {}, 'Authorization': "token #{token}").get
      JSON.parse response.body
    end

    class RequestError < StandardError; end
  end
end

