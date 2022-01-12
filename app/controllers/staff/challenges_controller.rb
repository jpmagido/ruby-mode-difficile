# frozen_string_literal: true

module Staff
  class ChallengesController < ApplicationController
    helper_method :challenges, :challenge

    def new
      @new_challenge = Challenge.new
    end

    def create
      @new_challenge = Challenge.new(user_id: current_user.id)
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
      if challenge.update(challenge_params)
        flash[:success] = t('challenges.flashes.update-challenge-success')
        redirect_to staff_challenge_path(challenge)
      else
        flash.now[:error] = t('challenges.flashes.challenge-error')
        render 'staff/challenges/edit'
      end
    end

    def destroy
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
      @challenges ||= Challenge.all
    end

    def challenge
      @challenge ||= challenges.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(
        :title,
        :github_url,
        :description,
        :url,
        :signature,
        :duration,
        :difficulty,
        :status,
        files: []
      )
    end
  end
end
