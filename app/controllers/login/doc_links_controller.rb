# frozen_string_literal: true

module Login
  class DocLinksController < Login::BaseController

    def new
      @new_doc_link = DocLink.new
      @challenges = Challenge.by_owner(current_user.id).order(:created_at)
      @answers = Answer.by_owner(current_user.id).order(:created_at)
      @docs = Doc.all.order(:title)
    end

    def create
      @new_doc_link = linkable.doc_links.new(doc_id: doc_link_params[:doc_id])
      authorize @new_doc_link

      if @new_doc_link.save
        flash[:success] = t('staff.doc_links.flashes.create-success')
        redirect_to login_doc_path(@new_doc_link.doc)
      else
        flash.now[:error] = t('staff.doc_links.flashes.error', error: @new_doc_link.errors.messages)
        render 'login/doc_links/new'
      end
    end

    private

    def linkable
      return Challenge.find(doc_link_params[:challenge_id]) if doc_link_params[:challenge_id]
      return Answer.find(doc_link_params[:answer_id]) if doc_link_params[:answer_id]
    end

    def doc_link_params
      params.require(:doc_link).permit(:challenge_id, :answer_id, :doc_id)
    end
  end
end
