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
      check_duration_params
      Challenge.where(filter_params).where('duration >= ? AND duration <= ?', default_min, default_max)
    end

    def challenge
      @challenge ||= challenges.find(params[:id])
    end

    def check_duration_params
      negative_duration = default_max.to_i < default_min.to_i
      redirect_to staff_challenges_path, alert: t('staff.challenges.flashes.duration-error') if negative_duration
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

    def filter_params
      params.permit(:difficulty, :status).to_h.select { |_, v| v.present? }
    end

    def default_min
      params[:duration_min].present? ? params[:duration_min] : 1
    end

    def default_max
      params[:duration_max].present? ? params[:duration_max] : 1000
    end
  end
end
