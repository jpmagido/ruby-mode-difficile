# frozen_string_literal: true

module Github
  module Sync
    class Repository
      attr_accessor :params, :klass, :errors

      def initialize(params, klass:)
        @params = params
        @klass = klass
        @errors = []

        raise ArgumentError, 'polymorphic associated class missing' unless klass
        raise ArgumentError, 'Controller parameters missing' unless params.is_a? ActionController::Parameters
      end

      def save_polymorphic
        ActiveRecord::Base.transaction do
          klass.assign_attributes sanitize_params
          klass.save!
          repository.save!
        end
        true

      rescue StandardError => e
        @errors << e # << repository.errors.messages << builded_klass.errors.messages
        false
      end

      private

      def repository
        @repository ||= klass.build_repository github_url: params[:repository][:github_url]
      end

      def sanitize_params
        params.except(:repository)
      end
    end
  end
end
