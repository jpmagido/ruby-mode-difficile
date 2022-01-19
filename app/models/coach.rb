# frozen_string_literal: true

class Coach < ApplicationRecord
  belongs_to :user

  enum status: %i[pending ready]
end
