# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: :uuid do |t|
      t.string :github_url
      t.string :youtube_url
      t.string :signature
      t.integer :status, default: 0
      t.text :comments

      t.belongs_to :challenge, null: false, foreign_key: true, type: :uuid
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
