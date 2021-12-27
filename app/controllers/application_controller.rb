# frozen_string_literal: true

class ApplicationController < ActionController::Base
  if Rails.env.production?
    rescue_from StandardError, with: :standard_errors
  end

  private

  def standard_errors(err)
    Rails.logger.fatal(err.exception)
    render template: 'errors/500', status: 500, locals: { errors: err }
  end
end
