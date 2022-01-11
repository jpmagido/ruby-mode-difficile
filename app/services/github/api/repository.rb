# frozen_string_literal: true

require 'base64'
require 'net/http'
require 'uri'

module Github
  module Api
    class Repository
      attr_reader :owner_name, :repo_name

      def initialize(owner_name:, repo_name:)
        @owner_name = owner_name
        @repo_name = repo_name

        raise ArgumentError, 'repo owner name must me provided: string' unless owner_name.is_a? String
        raise ArgumentError, 'repo name must be provided: string' unless repo_name.is_a? String
      end

      def readme
        Base64.decode64 JSON.parse(readme_json_response.body)['content']
      end

      private

      def readme_json_response
        @readme_json_response ||= HttpService.new(readme_url, {}, 'Accept': 'application/vnd.github.v3+json').get
      end

      def readme_url
        "https://api.github.com/repos/#{owner_name}/#{repo_name}/readme"
      end
    end
  end
end
