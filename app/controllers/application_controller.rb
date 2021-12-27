# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :standard_errors

  private

  def standard_errors(err)
    Rails.logger.fatal(err)
    redirect_to controller: ErrorsController, action: 'show', params: { errors: err }
  end
end
