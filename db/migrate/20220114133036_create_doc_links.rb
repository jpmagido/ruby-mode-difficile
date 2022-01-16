# frozen_string_literal: true

class CreateDocLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :doc_links, id: :uuid do |t|
      t.belongs_to :doc, null: false, foreign_key: true, type: :uuid
      t.references :linkable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
