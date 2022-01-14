# frozen_string_literal: true

module Login
  class DocsController < Login::BaseController
    helper_method :docs, :doc

    def index
      @count_phrase = "#{docs_count} #{'document'.pluralize(docs_count)}"
    end

    private

    def docs
      @docs ||= Doc.all
    end

    def doc
      @doc ||= docs.find(params[:id])
    end

    def docs_count
      @docs_count ||= Doc.count
    end
  end
end
