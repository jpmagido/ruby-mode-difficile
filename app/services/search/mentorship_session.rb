# frozen_string_literal: true

module Search
  class MentorshipSession < Search::Base
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
  end
end
