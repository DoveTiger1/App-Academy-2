class Collection < ApplicationRecord
    validates :name, :user_id, presence: true
    validates :user_id, uniqueness: {scope: [:name]}

    belongs_to :user
    has_many :artworks_collections, dependent: :destroy
    has_many :artworks, through: :artworks_collections
end