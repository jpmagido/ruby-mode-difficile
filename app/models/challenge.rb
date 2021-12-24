class Challenge < ApplicationRecord
  validates_length_of :description, in: 2..2000
  validates_length_of :title, in: 2..100
  validates_length_of :signature, in: 2..100
  validates :url, format: URI.regexp(%w[http https])
  validates_presence_of :time
  validates_presence_of :difficulty

  enum status: %i[pending valid]
end
