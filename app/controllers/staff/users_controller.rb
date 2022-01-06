# frozen_string_literal: true

module Staff
  class UsersController < ApplicationController
    helper_method :users, :user

    def update
      if user.update(user_params)
        flash[:success] = t('staff.users.flashes.update-success')
        redirect_to staff_user_path user
      else
        flash.now[:success] = t('staff.users.flashes.error', err: user.errors.messages)
        render 'staff/users/edit'
      end
    end

    def destroy
      user.update(active: false)
      flash[:success] = t('staff.users.flashes.destroy-success')
      redirect_to staff_user_path user
    end

    private

    def users
      @users ||= User.all
    end

    def user
      @user ||= users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:active, :language)
    end
  end
end
