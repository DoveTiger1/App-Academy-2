# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates :title, :image_url, :artist_id, presence: true
    validates :title, uniqueness: { scope: :artist_id, message: "Artist can't have artworks with repeated names"}

    belongs_to(
        :artist,
        class_name: 'User',
        foreign_key: :artist_id,
        primary_key: :id
    )

    has_many(
        :shares,
        class_name: 'ArtworkShare',
        foreign_key: :artwork_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :shared_viewers,
        through: :shares,
        source: :viewer
    )

    has_many(
        :comments,
        class_name: 'Comment',
        foreign_key: :artwork_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many :artworks_collections
    has_many :collections, through: :artworks_collections
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :users_who_liked,
        through: :likes,
        source: :user
end
