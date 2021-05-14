# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  artwork_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
    validates :body, :author_id, :artwork_id, presence: true

    belongs_to(
        :author,
        class_name: 'User',
        foreign_key: :author_id,
        primary_key: :id
    )

    belongs_to(
        :artwork,
        class_name: 'Artwork',
        foreign_key: :artwork_id,
        primary_key: :id
    )

    has_many :likes, as: :likeable, dependent: :destroy
    has_many :users_who_liked,
        through: :likes,
        source: :user
        
end
