class ShortenedUrl < ApplicationRecord
    validates :short_url, :user_id, :long_url, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming
    validate :nonpremium_max

    def self.new_with_user_and_long_url(user, long_url)
        self.create!(
            user_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    def self.random_code
        random_string = SecureRandom::urlsafe_base64
        while ShortenedUrl.exists?(:short_url => random_string)
            random_string = SecureRandom::urlsafe_base64
        end
        random_string
    end

    def self.prune(minutes)
        ShortenedUrl
      .joins(:submitter)
      .joins('LEFT JOIN visits ON visits.url_id = shortened_urls.id')
      .where("(shortened_urls.id IN (
        SELECT shortened_urls.id
        FROM shortened_urls
        JOIN visits
        ON visits.url_id = shortened_urls.id
        GROUP BY shortened_urls.id
        HAVING MAX(visits.created_at) < \'#{minutes.minute.ago}\'
      ) OR (
        visits.id IS NULL and shortened_urls.created_at < \'#{minutes.minutes.ago}\'
      )) AND users.premium = \'f\'")
      .destroy_all
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.select('user_id').count
    end

    def num_recent_uniques
        visits.select('user_id')
        .where('created_at > ?', 10.minutes.ago)
        .distinct
        .count
    end

    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :url_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :visitors,
        -> { distinct },
        through: :visits,
        source: :visitor
    )

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :url_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :tags,
        through: :taggings,
        source: :tag
    )

    private

    def no_spamming
        num = ShortenedUrl.where('user_id = ?', self.user_id)
        .where('created_at >= ?', 1.minutes.ago).count

        errors[:maximum] << 'of 5 links per minute' if num >= 5
    end

    def nonpremium_max
        num = ShortenedUrl.where('user_id = ?', self.user_id)
        .count

        errors[:maximum] << 'of 5 links per free user' if num >= 5
    end 
end