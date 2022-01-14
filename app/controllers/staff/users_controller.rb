# frozen_string_literal: true

module Staff
  class UsersController < Staff::BaseController
    helper_method :users, :user

    def update
      authorize user, policy_class: AdminPolicy

      if user.update(user_params)
        flash[:success] = t('staff.users.flashes.update-success')
        redirect_to staff_user_path user
      else
        flash.now[:success] = t('staff.users.flashes.error', err: user.errors.messages)
        render 'staff/users/edit'
      end
    end

    def destroy
      authorize user, policy_class: AdminPolicy

      user.update(active: false)
      flash[:success] = t('staff.users.flashes.destroy-success')
      redirect_to staff_user_path user
    end

    private

    def users
      @users ||= User.all - User.admins
    end

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:active, :language)
    end
  end
end
