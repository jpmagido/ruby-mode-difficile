# frozen_string_literal: true

module Search
  class Base
    attr_accessor :klass_scope
    attr_reader :params

    def initialize(klass_scope, params)
      @klass_scope = klass_scope
      @params = params
    end

    def search
      # Define new Search::Object with private methods for Controller Params hash keys
      # Use 'value' as an argument for Controller Params hash values
      sanitized_params.each { |key, value| self.klass_scope = send key, value }

      klass_scope
    end

    protected

    def sanitized_params
      params.to_h.select { |_, value| value.present? }
    end
  end
end
