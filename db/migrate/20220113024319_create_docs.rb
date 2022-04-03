# frozen_string_literal: true

class CreateDocs < ActiveRecord::Migration[7.0]
  def change
    create_table :docs, id: :uuid do |t|
      t.string :title, null: false
      t.string :tags
      t.text :content_fr
      t.text :content_en
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
