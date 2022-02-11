# frozen_string_literal: true

class CreateMentorships < ActiveRecord::Migration[7.0]
  def change
    create_table :mentorships, id: :uuid do |t|
      t.boolean :coach_approval, default: false
      t.boolean :student_approval, default: false
      t.boolean :active, default: true

      t.belongs_to :student, null: false, foreign_key: true, type: :uuid
      t.belongs_to :coach, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
