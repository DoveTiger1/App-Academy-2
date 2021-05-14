class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
    end

    add_index :collections, [:user_id, :name], unique: true
  end
end
