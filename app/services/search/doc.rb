# frozen_string_literal: true

module Search
  # TODO: spec
  class Doc < Search::Base
    private

    def title(value)
      klass_scope.where('title ~* ?', value)
    end

    def tag(value)
      klass_scope.where('tags ~* ?', value)
    end

    def challenge_id(value)
      klass_scope.joins(:doc_links).where('doc_links.linkable_id = ?', value)
    end

    def answer_id(value)
      klass_scope.joins(:doc_links).where('doc_links.linkable_id = ?', value)
    end
  end
end
