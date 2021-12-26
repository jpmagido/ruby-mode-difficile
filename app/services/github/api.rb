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
    end

    def find_user
      HttpService.new(GET_USER_URL, {}, 'Authorization': "token #{token}").get
    end

    class RequestError < StandardError; end
  end
end

