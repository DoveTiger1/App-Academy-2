class Question < ApplicationRecord
    validates :text, presence: true
    validates :poll_id, presence: true

    has_many(
        :answer_choices,
        class_name: 'AnswerChoice',
        foreign_key: :question_id,
        primary_key: :id,
        dependent: :destroy
    )

    belongs_to(
        :poll,
        class_name: 'Poll',
        foreign_key: :poll_id,
        primary_key: :id
    )

    has_many(
        :responses,
        through: :answer_choices,
        source: :responses
    )

    def results
        results = Hash.new(0)
        choices = self.answer_choices
        .select('answer_choices.*, COUNT(responses.*) as n_votes')
        .left_outer_joins(:responses)
        .group(:id)

        choices.each do |choice|
            results[choice.text] = choice.n_votes
        end

        results
    end
end