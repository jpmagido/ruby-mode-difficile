# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  validates_presence_of :github_url
  validates_presence_of :signature
  validates_presence_of :comments

  enum status: %i[pending ready]
end
