# frozen_string_literal: true

require 'net/http'
require 'uri'

module Github
  module Api
    class Repository
      attr_reader :token, :cloud_storage

      GET_README_URL = 'https://api.github.com/user/repo/readme/dir'

      def initialize(token:, cloud_storage:)
        @token = token
        @cloud_storage = cloud_storage

        raise ArgumentError, 'token must be present' unless token
        raise ArgumentError, 'url github must be present' unless cloud_storage
      end

      def get_readme
        response = HttpService.new(GET_README_URL, {}, 'Authorization': "token #{token}").readme
        p JSON.parse response.body
        #JSON.parse response.body
      end
    end
  end
end
