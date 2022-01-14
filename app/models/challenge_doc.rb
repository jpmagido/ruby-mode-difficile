# frozen_string_literal: true

class ChallengeDoc < ApplicationRecord
  belongs_to :doc
  belongs_to :challenge
end
