# frozen_string_literal: true

module Github
  module Sync
    class Session
      attr_reader :github_user, :request, :token

      def initialize(github_user, request, token)
        @github_user = github_user.symbolize_keys
        @request = request
        @token = token

        raise ArgumentError, 'token must be present' unless token
        raise ArgumentError, 'request must be present' unless request
        raise ArgumentError, 'github_user[:id] must be present' unless @github_user[:id]
      end

      def build
        destroy_all_user_sessions!
        ::Session.new(user_id: user.id, ip_address: ip_address, token: token)
      end

      private

      def destroy_all_user_sessions!
        ::Session.where(user_id: user.id).destroy_all
      end

      def user
        @user ||= ::User.find_by(github_id: github_user[:id])
      end

      def ip_address
        if Rails.env.production?
          request.remote_ip
        else
          Net::HTTP.get(URI.parse(ENV['IP_CHECK_URL'])).squish
        end
      end
    end
  end
end
