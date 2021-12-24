# frozen_string_literal: true

class Challenge < ApplicationRecord
  validates_length_of :description, in: 2..2000
  validates_length_of :title, in: 2..100
  validates :url, format: URI.regexp(%w[http https])
  validates_presence_of :duration
  validates_presence_of :difficulty
  validates_length_of :signature, in: 2..100

  enum status: %i[pending ready]

  has_many_attached :files

  scope :all_valid, -> { where('status = 1') }
end
