# frozen_string_literal: true

class Mentorship < ApplicationRecord
  belongs_to :student
  belongs_to :coach
end
