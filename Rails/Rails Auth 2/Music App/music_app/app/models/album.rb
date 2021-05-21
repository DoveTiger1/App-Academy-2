class Album < ApplicationRecord
    validates :name, :year, :band_id, presence: true
    validates :band_id, uniqueness: { scope: :name, message: 'band already has an album with that name'}

    belongs_to :band
    has_many :tracks, dependent: :destroy
end