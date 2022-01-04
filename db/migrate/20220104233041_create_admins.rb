# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
