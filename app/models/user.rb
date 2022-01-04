# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges
  has_many :answers

  has_one :session
end
