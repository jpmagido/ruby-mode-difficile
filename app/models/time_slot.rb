# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  belongs_to :mentorship_session
end
