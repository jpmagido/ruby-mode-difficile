# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user

  has_many :mentorships

  has_rich_text :description

  enum status: %i[pending ready blocked]
end
