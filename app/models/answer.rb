# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  has_one :repository, as: :cloud_storage
  has_many :doc_links, as: :linkable, dependent: :destroy

  validates_presence_of :signature
  validates_presence_of :comments

  enum status: %i[pending ready]

  has_one_attached :file

  delegate :title, to: :challenge
end
