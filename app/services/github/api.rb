# frozen_string_literal: true

require 'net/http'
require 'uri'

module Github
  module Api
    class User
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
    end

    class Repository
      
    end
  end
end

