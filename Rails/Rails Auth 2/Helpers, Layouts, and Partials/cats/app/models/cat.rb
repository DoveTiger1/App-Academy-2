class Cat < ApplicationRecord
    COLORS = %w[black white spotted]

    validates :birth_date, :color, :name, :sex, :user_id, presence: true
    validates :color, inclusion: {in: COLORS, message: 'is not valid'}
    validates :sex, inclusion: {in: %w[M F]}
    validate :not_negative_age

    def age
        return Time.now.year- birth_date.year
    end

    has_many(
        :rental_requests,
        class_name: 'CatRentalRequest',
        foreign_key: :cat_id,
        primary_key: :id,
        dependent: :destroy
    )

    belongs_to(
        :owner,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    private

    def not_negative_age
        if self.birth_date.nil? || self.birth_date > Time.now
            errors[:age] << 'Cant be negative'
        end
    end

end