# frozen_string_literal: true

module Github
  module Sync
    class User
      attr_reader :github_user

      def initialize(github_user)
        @github_user = github_user.symbolize_keys

        raise ArgumentError, 'You must provide an ID' if github_id.nil?
      end

      def synced_user
        user = ::User.find_or_initialize_by(github_id: github_id)
        user.assign_attributes(user_attributes)
        user
      end

      private

      def github_id
        @github_id ||= github_user[:id]
      end

      def user_attributes
        github_user.slice(:login, :bio, :email, :html_url, :avatar_url, :blog, :followers)
      end

      class Error < StandardError; end
    end
  end
end
