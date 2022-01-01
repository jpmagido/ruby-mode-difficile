# frozen_string_literal: true

module Login
  class UsersController < Login::BaseController
    rescue_from NoMethodError, with: :to_login
  end
end
