# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories, id: :uuid do |t|
      t.text :github_url
      t.text :readme
      t.references :cloud_storage, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
