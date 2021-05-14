class Cat < ApplicationRecord
    COLORS = %w[black white spotted]

    validates :birth_date, :color, :name, :sex, presence: true
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

    private

    def not_negative_age
        if self.birth_date.nil? || self.birth_date > Time.now
            errors[:age] << 'Cant be negative'
        end
    end

end