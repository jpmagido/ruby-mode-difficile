# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges, dependent: :restrict_with_exception
  has_many :answers, dependent: :restrict_with_exception

  has_one :session, dependent: :destroy
  has_one :admin, dependent: :destroy

  enum language: %i[fr en]

  scope :admins, -> { joins(:admin) }
end
