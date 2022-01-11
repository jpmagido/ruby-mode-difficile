class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories, id: :uuid do |t|
      t.text :url
      t.text :readme
      t.references :cloud_storage, polymorphic: true

      t.timestamps
    end
  end
end
