# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.integer :github_id, null: false
      t.string :login, null: false
      t.string :email, default: 'NC'
      t.text :bio, default: 'NC'
      t.text :html_url, default: 'NC'
      t.text :avatar_url, default: 'NC'
      t.text :blog, default: 'NC'
      t.integer :followers, default: 'NC'
      t.integer :language, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
