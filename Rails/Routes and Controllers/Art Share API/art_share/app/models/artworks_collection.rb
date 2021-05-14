class ArtworksCollection < ApplicationRecord
    validates :artwork_id, :collection_id, presence: true
    validates :artwork_id, uniqueness: {scope: [:collection_id]}

    belongs_to :collection
    belongs_to :artwork
end