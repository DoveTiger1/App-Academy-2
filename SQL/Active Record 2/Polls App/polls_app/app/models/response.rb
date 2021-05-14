class Response < ApplicationRecord
    validates :answer_id, presence: true
    validates :user_id, presence: true
    validate :not_duplicate_response, unless: -> { answer_choice.nil? }
    validate :responding_to_own_poll_improved

    belongs_to(
        :answer_choice,
        class_name: 'AnswerChoice',
        foreign_key: :answer_id,
        primary_key: :id
    )

    belongs_to(
        :respondent,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_one(
        :question,
        through: :answer_choice,
        source: :question
    )

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(user_id: self.user_id) 
    end

    def responding_to_own_poll?
        self.question.poll.author_id == self.user_id
    end

    def responding_to_own_poll_improved
        poll_author_id = Poll.joins(questions: :answer_choices)
        .where('answer_choices.id = ?', self.answer_id)
        .pluck('polls.author_id')
        .first

        if poll_author_id == self.user_id
            errors[:user_id] << 'cannot vote on own poll'
        end

    end

    private

    def not_duplicate_response
        if respondent_already_answered?
            errors[:user_id] << 'cannot vote twice for question'
        end
    end

    def cant_respond_to_own_poll
        if responding_to_own_poll?
            errors[:user_id] << 'cannot vote on own poll'
        end
    end
end