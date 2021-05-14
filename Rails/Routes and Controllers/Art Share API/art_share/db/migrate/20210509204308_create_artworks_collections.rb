class CreateArtworksCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks_collections do |t|
      t.integer :artwork_id, null: false
      t.integer :collection_id, null: false
    end

    add_index :artworks_collections, [:artwork_id, :collection_id], unique: true
  end
end
