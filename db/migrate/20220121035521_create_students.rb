# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: :uuid do |t|
      t.integer :status, default: 0

      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
