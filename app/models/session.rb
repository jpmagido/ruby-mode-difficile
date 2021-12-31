# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user
  before_save :encode

  def encode
    Security::EncoderService.new(token: token).encode
  end

  #def token
  #  Security::EncoderService.new(token: token).decode
  #end
end
