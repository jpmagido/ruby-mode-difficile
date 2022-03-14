# frozen_string_literal: true

# Model must have token attr as string
module JwtToken
  extend ActiveSupport::Concern

  def token
    Security::JwtService.new(token: super).decode
  end

  private

  def encode_token
    self[:token] = Security::JwtService.new(token: self[:token]).encode
  end
end
