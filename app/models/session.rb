# frozen_string_literal: true

class Session < ApplicationRecord
  include JwtToken

  belongs_to :user
  before_save :encode_token
end
