class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.integer :github_id
      t.string :name
      t.text :biography
      t.text :github_url
      t.text :avatar_url
      t.text :personal_url
      t.integer :repos_count
      t.integer :followers

      t.timestamps
    end
  end
end
