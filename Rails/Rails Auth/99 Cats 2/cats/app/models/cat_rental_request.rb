class CatRentalRequest < ApplicationRecord
    STATUSES = %w[PENDING APPROVED DENIED].freeze

    validates :cat_id, :start_date, :end_date, :status, presence: true
    validates :status, inclusion: {in: STATUSES, message: 'is not valid'}
    validate :doesnt_overlap
    validate :end_before_start

    belongs_to :cat

    def approve!
        raise 'not pending!' if self.status != 'PENDING'
        transaction do
            self.status = 'APPROVED'
            self.save!
            
            overlapping_pending_requests.each do |request|
                request.update!(status: 'DENIED')
            end
            
        end
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    def pending?
        return self.status == 'PENDING'
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: 'PENDING')
    end

    def overlapping_requests
        CatRentalRequest
        .where(['cat_id = ? AND ((start_date < ? AND end_date > ?) OR start_date BETWEEN ? AND ?)',self.cat_id, self.start_date, self.end_date, self.start_date, self.end_date])
        .where.not(id: self.id)
    end

    private

    def doesnt_overlap
        return if self.status == 'DENIED'
        if overlapping_approved_requests.exists?
            errors[:base] << 'There are overlapping requests'
        end
        true
    end

    def end_before_start
        return if start_date < end_date
        errors[:start_date] << 'must come before end date'
        errors[:end_date] << 'must come after start date'
    end
end