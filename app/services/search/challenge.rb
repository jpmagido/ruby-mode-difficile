# frozen_string_literal: true

module Search
  class Challenge < Search::Base
    private

    def title(value)
      klass_scope.where('title ~* ?', value)
    end

    def user_id(value)
      klass_scope.where(user_id: value)
    end

    def doc_id(value)
      klass_scope.joins(:doc_links).where('doc_links.doc_id = ?', value)
    end

    def difficulty(value)
      klass_scope.where(difficulty: value.to_i)
    end

    def duration_min(value)
      klass_scope.where('duration > ?', value)
    end

    def duration_max(value)
      klass_scope.where('duration < ?', value)
    end

    def status(value)
      klass_scope.where(status: value)
    end
  end
end
