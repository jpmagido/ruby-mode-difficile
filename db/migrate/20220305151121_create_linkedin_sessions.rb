# frozen_string_literal: true

class CreateLinkedinSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :linkedin_sessions, id: :uuid do |t|
      t.string :token, null: false
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
