# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user

  has_many :mentorships

  enum status: %i[ready blocked]
end
