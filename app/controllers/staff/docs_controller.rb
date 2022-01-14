# frozen_string_literal: true

module Staff
  class DocsController < ApplicationController
    helper_method :docs, :doc

    def new
      @new_doc = Doc.new
      authorize @new_doc, policy_class: AdminPolicy
    end

    def create
      @new_doc = Doc.new(doc_params)
      authorize @new_doc, policy_class: AdminPolicy

      if @new_doc.save
        flash[:success] = t('docs.flashes.create-success')
        redirect_to staff_doc_path(@new_doc)
      else
        flash.now[:error] = t('docs.flashes.error', error: doc.errors.messages)
        render 'staff/docs/new'
      end
    end

    def update
      authorize doc, policy_class: AdminPolicy

      if doc.update(doc_params)
        flash[:success] = t('docs.flashes.update-success')
        redirect_to staff_doc_path(doc)
      else
        flash.now[:error] = t('docs.flashes.error', error: doc.errors.messages)
        render 'staff/docs/edit'
      end
    end

    def destroy
      authorize doc, policy_class: AdminPolicy

      if doc.destroy
        flash[:success] = t('docs.flashes.destroy-success')
        redirect_to staff_docs_path
      else
        flash[:error] = t('docs.flashes.error', error: doc.errors.messages)
        redirect_to staff_doc_path(doc)
      end
    end

    private

    def docs
      @docs ||= Doc.all
    end

    def doc
      @doc ||= docs.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content, :tags)
    end
  end
end
