# frozen_string_literal: true

class CreateConversationParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_participants, id: :uuid do |t|
      t.belongs_to :conversation, null: false, foreign_key: true, type: :uuid
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
