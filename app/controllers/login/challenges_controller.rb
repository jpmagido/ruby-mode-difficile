# frozen_string_literal: true

module Login
  class ChallengesController < Login::BaseController
    helper_method :challenges, :challenge

    def new
      @new_challenge = Challenge.new
    end

    def create
      @new_challenge = Challenge.new(user_id: current_user.id)
      syncer = Github::Sync::Repository.new(challenge_params, klass: @new_challenge)

      if syncer.save_polymorphic
        flash[:success] = t('challenges.flashes.new-challenge-success')
        redirect_to login_challenge_path(@new_challenge)
      else
        flash.now[:notice] = t(
          'challenges.flashes.new-challenge-error',
          error: syncer.errors
        )
        render action: :new
      end
    end

    private

    def challenges
      @challenges ||= Challenge.all_valid
    end

    def challenge
      @challenge ||= Challenge.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(
        :title,
        :description,
        :signature,
        :duration,
        :difficulty,
        files: [],
        repository: [:github_url]
      )
    end
  end
end
