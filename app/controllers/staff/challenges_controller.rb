# frozen_string_literal: true

module Staff
  class ChallengesController < Staff::BaseController
    helper_method :challenges, :challenge

    def new
      @new_challenge = Challenge.new
      authorize @new_challenge, policy_class: AdminPolicy
    end

    def create
      @new_challenge = Challenge.new(user_id: current_user.id)
      authorize @new_challenge, policy_class: AdminPolicy

      syncer = Github::Sync::Repository.new(challenge_params, klass: @new_challenge)

      if syncer.save_polymorphic
        flash[:success] = t('challenges.flashes.new-challenge-success')
        redirect_to staff_challenge_path(@new_challenge)
      else
        flash.now[:error] = t('challenges.flashes.challenge-error', error: syncer.errors)
        render 'staff/challenges/new'
      end
    end

    def update
      authorize challenge, policy_class: AdminPolicy

      syncer = Github::Sync::Repository.new(challenge_params, klass: challenge)

      if syncer.save_polymorphic
        flash[:success] = t('challenges.flashes.update-challenge-success')
        redirect_to staff_challenge_path(challenge)
      else
        flash.now[:error] = t('challenges.flashes.challenge-error')
        render 'staff/challenges/edit'
      end
    end

    def destroy
      authorize challenge, policy_class: AdminPolicy

      if challenge.destroy
        flash[:success] = t('challenges.flashes.destroy-challenge-success')
        redirect_to staff_challenges_path
      else
        flash.now[:error] = t('challenges.flashes.challenge-error')
        redirect_to :back
      end
    end

    private

    def challenges
      if params[:difficulty]
        @challenges = Challenge.where(['difficulty = ?', params[:difficulty]])
        return @challenges
      else
        @challenges ||= Challenge.all
        return @challenges
      end
    end

    def challenge
      @challenge ||= challenges.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(
        :title,
        :description,
        :signature,
        :duration,
        :difficulty,
        :status,
        files: [],
        repository: [:github_url]
      )
    end
  end
end
