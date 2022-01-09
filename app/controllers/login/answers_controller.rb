# frozen_string_literal: true

module Login
  class AnswersController < Login::BaseController
    helper_method :answer, :challenge

    def new
      @new_answer = Answer.new
    end

    def create
      @new_answer = current_user.answers.new(answer_params.merge(challenge_id: challenge.id))

      if @new_answer.save
        flash[:success] = t('answers.flashes.create-success')
        redirect_to login_challenge_answer_path(challenge, @new_answer)
      else
        flash[:error] = t('answers.flashes.error', err: @new_answer.errors.messages)
        render 'login/answers/new'
      end
    end

    private

    def challenge
      @challenge ||= Challenge.find(params[:challenge_id])
    end

    def answer
      @answer ||= challenge.answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:github_url, :youtube_url, :signature, :comments)
    end
  end
end
