# frozen_string_literal: true

class Mentorship < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  belongs_to :student
  belongs_to :coach

  has_many :mentorship_sessions, dependent: :destroy

  def show_page_student
    link_to(I18n.t('students.version'), academy_mentorship_path(self))
  end

  def show_page_coach
    link_to(I18n.t('coaches.version'), mentor_mentorship_path(self))
  end
end
