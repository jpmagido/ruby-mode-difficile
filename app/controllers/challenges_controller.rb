# frozen_string_literal: true

class ChallengesController < ApplicationController
  helper_method :challenges, :challenge

  def new
    @new_challenge = Challenge.new
  end

  def create
    @new_challenge = Challenge.new(challenge_params)

    if @new_challenge.save
      flash[:success] = t('challenges.flashes.new-challenge-success')
      redirect_to challenge_path(@new_challenge)
    else
      # flash.now[:notice] = t('challenges.flashes.new-challenge-error', error: @new_challenge.errors.messages)
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
    params.require(:challenge).permit(:title, :description, :url, :signature, :duration, :difficulty, files: [])
  end
end
