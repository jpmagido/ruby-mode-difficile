# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user
  before_save :encode_token

  def token
    Security::EncoderService.new(token: super).decode
  end

  private

  def encode_token
    Security::EncoderService.new(token: self[:token]).encode
  end
end
