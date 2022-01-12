# frozen_string_literal: true

require 'base64'
require 'net/http'
require 'uri'

module Github
  module Api
    class Repository
      attr_reader :github_url

      def initialize(github_url:)
        @github_url = github_url

        raise ArgumentError, 'repo owner name must me provided: string' unless github_url.is_a? String
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

      def owner_name
        github_url.split('/').last(2).first
      end

      def repo_name
        github_url.split('/').last
      end
    end
  end
end
