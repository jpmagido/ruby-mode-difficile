# frozen_string_literal: true

class MentorshipSession < ApplicationRecord
  after_create :create_time_slots

  belongs_to :mentorship

  has_many :time_slots, dependent: :destroy

  scope :ready, -> { joins(:time_slots).where(time_slots: { coach_approval: true, student_approval: true }) }

  DAY_BEGINS_AT = 7
  DAY_ENDS_AT = 21

  def approved_time_slots
    time_slots.where(coach_approval: true, student_approval: true)
  end

  def student_approved_time_slots
    time_slots.where(coach_approval: false, student_approval: true)
  end

  def coach_approved_time_slots
    time_slots.where(coach_approval: true, student_approval: false)
  end

  def duration
    (start_date..end_date).to_a.length
  end

  private

  def create_time_slots
    (start_date..end_date).each do |day|
      formatted_day = day.to_s.split('-').map(&:to_i)

      (DAY_BEGINS_AT...DAY_ENDS_AT).each do |hour|
        begin_hour = DateTime.new(*formatted_day + [hour])
        half_hour = DateTime.new(*formatted_day + [hour, 30])
        end_hour = DateTime.new(*formatted_day + [hour + 1])

        ActiveRecord::Base.transaction do
          time_slots.create!(start_date: begin_hour, end_date: half_hour)
          time_slots.create!(start_date: half_hour, end_date: end_hour)
        end
      end
    end
  end
end
