# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user
  before_save :encode_token

  def token
    Security::JwtService.new(token: super).decode
  end

  private

  def encode_token
    self[:token] = Security::JwtService.new(token: self[:token]).encode
  end
end
