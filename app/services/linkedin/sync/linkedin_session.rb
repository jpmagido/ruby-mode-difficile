# frozen_string_literal: true

module Linkedin
  module Sync
    # Makes sure User only has one LinkedinSession
    class LinkedinSession
      attr_reader :user, :linkedin_token

      def initialize(user, linkedin_token)
        @user = user
        @linkedin_token = linkedin_token
      end

      def sync
        ActiveRecord::Base.transaction do
          user.linkedin_session&.destroy!
          ::LinkedinSession.create!(token: linkedin_token, user_id: user.id)
        end

        true
      end
    end
  end
end
