# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges
  has_one :session
end
