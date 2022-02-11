# frozen_string_literal: true

class CreateTimeSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :time_slots, id: :uuid do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.boolean :coach_approval, default: false
      t.boolean :student_approval, default: false

      t.belongs_to :mentorship_session, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
