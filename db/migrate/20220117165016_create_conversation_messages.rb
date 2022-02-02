# frozen_string_literal: true

class CreateConversationMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_messages, id: :uuid do |t|
      t.text :content
      t.boolean :read

      t.belongs_to :conversation, null: false, foreign_key: true, type: :uuid
      t.belongs_to :conversation_participant, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
