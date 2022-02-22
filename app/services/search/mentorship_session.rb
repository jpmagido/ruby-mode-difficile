# frozen_string_literal: true

module Search
  # TODO: SPECS + REQUEST SPEC
  class MentorshipSession
    attr_accessor :klass_scope
    attr_reader :params

    def initialize(klass_scope, params)
      @klass_scope = klass_scope
      @params = params
    end

    def search
      sanitized_params.each { |key, value| self.klass_scope = send key, value }

      klass_scope
    end

    private

    def start_date(value)
      klass_scope.where('start_date >= ?', value)
    end

    def end_date(value)
      klass_scope.where('end_date <= ?', value)
    end

    def incoming(_)
      klass_scope.where('end_date >= ?', Time.zone.now.beginning_of_day)
    end

    def sanitized_params
      params.to_h.select { |_, value| value.present? }
    end
  end
end
