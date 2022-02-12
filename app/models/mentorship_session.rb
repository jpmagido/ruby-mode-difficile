# frozen_string_literal: true

class MentorshipSession < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  after_create :create_or_update_time_slots
  after_update :create_or_update_time_slots

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
    (start_date.to_date..end_date.to_date).to_a.length
  end

  def show_page
    [
      link_to(I18n.t('students.version'), academy_mentorship_session_path(self)),
      link_to(I18n.t('coaches.version'), mentor_mentorship_session_path(self))
    ]
  end

  private

  def create_or_update_time_slots
    (start_date.to_date..end_date.to_date).each do |day|
      formatted_day = day.to_s.split('-').map(&:to_i)
      (DAY_BEGINS_AT...DAY_ENDS_AT).each do |hour|
        begin_hour = DateTime.new(*formatted_day + [hour])
        half_hour = DateTime.new(*formatted_day + [hour, 30])
        end_hour = DateTime.new(*formatted_day + [hour + 1])

        ActiveRecord::Base.transaction do
          outdated_time_slots.each(&:destroy!)
          time_slots.find_or_create_by!(start_date: begin_hour, end_date: half_hour)
          time_slots.find_or_create_by!(start_date: half_hour, end_date: end_hour)
        end
      end
    end
  end

  def outdated_time_slots
    time_slots.where('start_date < ? OR end_date > ?', start_date.beginning_of_day, end_date.end_of_day)
  end
end
