# frozen_string_literal: true

module Staff
  class DocLinksController < Staff::BaseController
    def new
      @new_doc_link = DocLink.new
      authorize @new_doc_link, policy_class: AdminPolicy

      @challenges = Challenge.all.order(:title)
      @answers = Answer.all
      @docs = Doc.all.order(:title)
    end

    def create
      @new_doc_link = linkable.doc_links.new(doc_id: doc_link_params[:doc_id])
      authorize @new_doc_link, policy_class: AdminPolicy

      if @new_doc_link.save
        flash[:success] = t('staff.doc_links.flashes.create-success')
        redirect_to staff_doc_path(@new_doc_link.doc)
      else
        flash.now[:error] = t('staff.doc_links.flashes.error', error: @new_doc_link.errors.messages)
        render 'staff/doc_links/new'
      end
    end

    def destroy
      authorize doc_link, policy_class: AdminPolicy

      if doc_link.destroy
        flash[:success] = t('staff.doc_links.flashes.destroy-success')
        redirect_to staff_doc_path(doc_link.linkable)
      else
        flash[:error] = t('staff.doc_links.flashes.error', error: doc_link.errors.messages)
        redirect_to staff_challenge_path(doc_link.linkable)
      end
    end

    private

    def doc_link
      @doc_link ||= DocLink.find(params[:id])
    end

    def linkable
      return Challenge.find(doc_link_params[:challenge_id]) if doc_link_params[:challenge_id]
      return Answer.find(doc_link_params[:answer_id]) if doc_link_params[:answer_id]

      flash.now[:error] = t('staff.doc_links.new.linkable-error')
      render 'staff/doc_links/new'
    end

    def doc_link_params
      params.require(:doc_link).permit(:challenge_id, :answer_id, :doc_id)
    end
  end
end
