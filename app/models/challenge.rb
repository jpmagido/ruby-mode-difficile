# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :doc_links, as: :linkable, dependent: :destroy
  has_many_attached :files
  has_rich_text :description

  has_one :repository, as: :cloud_storage, dependent: :destroy

  validates_length_of :description, in: 2..2000
  validates_length_of :title, in: 2..100
  validates_presence_of :duration
  validates_presence_of :difficulty
  validates_length_of :signature, in: 2..100

  enum status: %i[pending ready]

  scope :all_valid, -> { where('status = 1') }
  scope :by_owner, ->(user_id) { where('user_id = ?', user_id) }
  scope :filter_by_difficulty, -> (difficulty) { where difficulty: difficulty }
  scope :filter_by_duration, -> (duration) { where duration: duration }
  scope :filter_by_status, -> (status) { where status: status }

  def display_nature
    "#{self.class.to_s} : #{title}"
  end

  def type_id
    "#{self.class.to_s}/#{id}"
  end
end
