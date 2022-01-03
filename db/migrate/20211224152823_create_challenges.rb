# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :difficulty
      t.integer :duration
      t.integer :status, default: 0
      t.string :url
      t.string :signature
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
