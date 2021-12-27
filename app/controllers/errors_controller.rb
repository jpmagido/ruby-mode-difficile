# frozen_string_literal: true

class ErrorsController < ApplicationController
  def show
    @errors = params[:errors]
    status_code = params[:code] || '500'
    render status_code.to_s, status: status_code
  end
end
