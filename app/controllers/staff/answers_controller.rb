# frozen_string_literal: true

module Staff
  class AnswersController < ApplicationController
    helper_method :answer, :answers

    def new
      @new_answer = Answer.new
    end

    def create
      @new_answer = Answer.new
      syncer = Github::Sync::Repository.new(create_answer_params, klass: @new_answer)

      if syncer.save_polymorphic
        flash[:success] = t('answers.flashes.create-success')
        redirect_to staff_answer_path(@new_answer)
      else
        flash[:error] = t('answers.flashes.error', err: syncer.errors)
        render 'staff/answers/new'
      end
    end

    def update
      if answer.update(answer_params)
        flash[:success] = t('staff.answers.flashes.update-success')
        redirect_to staff_answer_path(answer)
      else
        flash.now[:error] = t('answers.flashes.error', err: answer.errors.messages)
        render 'staff/answers/edit'
      end
    end

    def destroy
      answer.destroy
      flash[:success] = t('staff.answers.flashes.destroy-success')
      redirect_to staff_answers_path
    end

    private

    def answers
      @answers ||= Answer.all
    end

    def answer
      @answer ||= answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(
        :github_url,
        :youtube_url,
        :signature,
        :comments
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
