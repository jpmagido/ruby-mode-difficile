# frozen_string_literal: true

module Staff
  class AnswersController < ApplicationController
    helper_method :answer, :answers, :challenge

    def new
      @new_answer = Answer.new
      authorize @new_answer, policy_class: AdminPolicy
    end

    def create
      @new_answer = Answer.new
      authorize @new_answer, policy_class: AdminPolicy

      syncer = Github::Sync::Repository.new(create_answer_params, klass: @new_answer)

      if syncer.save_polymorphic
        flash[:success] = t('answers.flashes.create-success')
        redirect_to staff_challenge_answer_path(@new_answer.challenge, @new_answer)
      else
        flash[:error] = t('answers.flashes.error', err: syncer.errors)
        render 'staff/answers/new'
      end
    end

    def update
      authorize answer, policy_class: AdminPolicy

      if answer.update(answer_params)
        flash[:success] = t('staff.answers.flashes.update-success')
        redirect_to staff_challenge_answer_path(challenge, answer)
      else
        flash.now[:error] = t('answers.flashes.error', err: answer.errors.messages)
        render 'staff/answers/edit'
      end
    end

    def destroy
      authorize answer, policy_class: AdminPolicy

      answer.destroy
      flash[:success] = t('staff.answers.flashes.destroy-success')
      redirect_to staff_challenge_answers_path(challenge)
    end

    private

    def challenge
      @challenge ||= Challenge.find_by(id: params[:challenge_id])
    end

    def answers
      @answers ||= Answer.all
    end

    def answer
      @answer ||= answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(
        :youtube_url,
        :signature,
        :comments,
        repository: [:github_url],
      )
    end

    def create_answer_params
      answer_params.merge(
        challenge_id: params[:challenge_id],
        user_id: current_user.id
      )
    end
  end
end
