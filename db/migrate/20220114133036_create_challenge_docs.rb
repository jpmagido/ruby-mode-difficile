# frozen_string_literal: true

class CreateChallengeDocs < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_docs, id: :uuid do |t|
      t.belongs_to :doc, null: false, foreign_key: true, type: :uuid
      t.belongs_to :challenge, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
