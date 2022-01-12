# frozen_string_literal: true

module Login
  class AnswersController < Login::BaseController
    helper_method :answer, :challenge

    def show
      authorize answer
    end

    def new
      @new_answer = Answer.new
      authorize @new_answer
    end

    def create
      @new_answer = current_user.answers.new(challenge_id: challenge.id)
      authorize @new_answer

      syncer = Github::Sync::Repository.new(answer_params, klass: @new_answer)

      if syncer.save_polymorphic
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
      params.require(:answer).permit(
        :youtube_url,
        :signature,
        :comments,
        repository: [:github_url]
      )
    end
  end
end
