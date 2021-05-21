class Track < ApplicationRecord
    validates :album_id, :title, :ord, presence: true
    validates :album_id, uniqueness: { scope: :ord, 'two tracks can\' occupy the same spot'}

    belongs_to :album
end