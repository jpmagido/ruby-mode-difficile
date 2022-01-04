# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.string :ip_address, null: false
      t.string :token, null: false
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
