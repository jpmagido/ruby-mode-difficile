# frozen_string_literal: true

module Login
  class DocsController < Login::BaseController
    helper_method :docs, :doc

    private

    def docs
      @docs ||= Search::Doc.new(Doc.all_valid, search_params).search
    end

    def doc
      @doc ||= Doc.find(params[:id])
    end

    def search_params
      params.permit(:title, :tag, :challenge_id, :answer_id)
    end
  end
end
