class CreateDocs < ActiveRecord::Migration[7.0]
  def change
    create_table :docs, id: :uuid do |t|
      t.string :title, null: false
      t.string :tags
      t.text :content

      t.timestamps
    end
  end
end
