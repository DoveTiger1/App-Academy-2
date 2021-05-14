class Tagging < ApplicationRecord
    validates :url_id, :tag_id, presence: true

    belongs_to(
        :tag,
        class_name: 'TagTopic',
        foreign_key: :tag_id,
        primary_key: :id
    )

    belongs_to(
        :url,
        class_name: 'ShortenedUrl',
        foreign_key: :url_id,
        primary_key: :id
    )
end