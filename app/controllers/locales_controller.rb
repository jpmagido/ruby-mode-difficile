# frozen_string_literal: true

class LocalesController < ApplicationController
  def update
    current_user&.update!(language: params[:locale])
    session[:locale] = params[:locale]

    I18n.locale = params[:locale]
    flash[:success] = t('shared.update-locale')
    redirect_to request.env['HTTP_REFERER'] || root_path
  end
end
