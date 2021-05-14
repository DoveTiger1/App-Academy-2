class TagTopic < ApplicationRecord
    validates :name, presence: true

    def popular_links
        urls.joins(:visits).group(:short_url, :long_url).order('COUNT(visits.id) DESC')
        .select('long_url', 'short_url').limit(5)
    end

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :tag_id,
        primary_key: :id
    )

    has_many(
        :urls,
        through: :taggings,
        source: :url
    )
end