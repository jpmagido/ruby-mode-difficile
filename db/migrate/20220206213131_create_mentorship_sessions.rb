# frozen_string_literal: true

class CreateMentorshipSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentorship_sessions, id: :uuid do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.belongs_to :mentorship, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
