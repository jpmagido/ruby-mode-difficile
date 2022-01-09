# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  if Rails.env.production?
    rescue_from Github::Sync::User::Unauthorized, with: :unauthorized
    rescue_from StandardError, with: :standard_errors
  end

  protected

  def current_user
    @current_user ||= Session.find_by(id: session[:user_session_id])&.user
  end

  private

  def unauthorized(err)
    Rails.logger.error(err.exception)
    render template: 'errors/401', status: 401, locals: { errors: err }
  end

  def standard_errors(err)
    Rails.logger.fatal(err.exception)
    render template: 'errors/500', status: 500, locals: { errors: err }
  end
end
