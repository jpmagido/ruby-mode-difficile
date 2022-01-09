# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many_attached :files
  has_rich_text :description
  has_one :repository, as: :cloud_storage

  #validates_length_of :description, in: 2..2000
  #validates_length_of :title, in: 2..100
  #validates :url, format: URI.regexp(%w[http https])
  #validates_presence_of :duration
  #validates_presence_of :difficulty
  #validates_length_of :signature, in: 2..100

  enum status: %i[pending ready]

  scope :all_valid, -> { where('status = 1') }
end
