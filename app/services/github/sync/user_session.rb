# frozen_string_literal: true

module Github
  module Sync
    class UserSession
      attr_reader :token, :request

      def initialize(token, request)
        @token = token
        @request = request

        raise ArgumentError, 'token missing' unless token
        raise ArgumentError, 'request missing' unless request
      end

      def save_session!
        ActiveRecord::Base.transaction do
          user.save!
          user_session.save!
        end
        user_session.id
      end

      private

      def user
        @user ||= Github::Sync::User.new(github_user).synced_user
      end

      def user_session
        @user_session ||= Github::Sync::Session.new(github_user, request, token).build
      end

      def github_user
        @github_user ||= Github::Api.new(token).find_user
      end
    end
  end
end
