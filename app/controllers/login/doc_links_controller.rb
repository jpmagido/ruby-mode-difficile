# frozen_string_literal: true

module Login
  class DocLinksController < Login::BaseController

    def new
      @new_doc_link = DocLink.new
      @linkables = current_user_challenges + current_user_answers
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
      formatted_param = doc_link_params[:linkable].split('/')
      formatted_param.first.constantize.find(formatted_param.last)
    end

    def current_user_challenges
      @current_user_challenges ||= Challenge.by_owner(current_user.id).order(created_at: :desc)
    end

    def current_user_answers
      @current_user_answers ||= Answer.by_owner(current_user.id).order(created_at: :desc)
    end

    def doc_link_params
      params.require(:doc_link).permit(:linkable, :doc_id)
    end
  end
end
