class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.integer :github_id, null: false
      t.string :login
      t.string :email
      t.text :bio
      t.text :repos_url
      t.text :avatar_url
      t.text :blog
      t.integer :repos_count
      t.integer :followers
      t.integer :language, default: 0

      t.timestamps
    end
  end
end
