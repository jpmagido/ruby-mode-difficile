# frozen_string_literal: true

module Staff
  class ChallengeDocsController < ApplicationController
    helper_method :challenge_doc

    def new
      @new_challenge_doc = ChallengeDoc.new
      authorize @new_challenge, policy_class: AdminPolicy

      @challenges = Challenge.all.order(:title)
      @docs = Doc.all.order(:title)
    end

    def create
      @new_challenge_doc = ChallengeDoc.new(challenge_doc_params)
      authorize @new_challenge_doc, policy_class: AdminPolicy

      if @new_challenge_doc.save
        flash[:success] = t('staff.challenge_docs.flashes.create-success')
        redirect_to staff_challenge_path(@new_challenge_doc.challenge)
      else
        flash.now[:error] = t('staff.challenge_docs.flashes.error', error: @new_challenge_doc.errors.messages)
        render 'staff/challenge_docs/new'
      end
    end

    def destroy
      authorize challenge_doc, policy_class: AdminPolicy

      if challenge_doc.destroy
        flash[:success] = t('staff.challenge_docs.flashes.destroy-success')
      else
        flash[:error] = t('staff.challenge_docs.flashes.error', error: challenge_doc.errors.messages)
        redirect_to staff_challenge_path(challenge_doc.challenge)
      end
    end

    private

    def challenge_doc
      @challenge_doc ||= ChallengeDoc.find(params[:id])
    end

    def challenge_doc_params
      params.require(:challenge_doc).permit(:challenge_id, :doc_id)
    end
  end
end
