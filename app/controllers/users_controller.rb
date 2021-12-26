# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :user

  def show
  end

  private

  def user
    current_user
  end
end
