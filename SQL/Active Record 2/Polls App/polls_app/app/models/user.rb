class User < ApplicationRecord
    validates :username, presence: true
    validates :username, uniqueness: true
    after_destroy :log_destroy

    has_many(
        :authored_polls,
        class_name: 'Poll',
        foreign_key: :author_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(
        :responses,
        class_name: 'Response',
        foreign_key: :user_id,
        primary_key: :id,
        dependent: :destroy
    )

    def log_destroy
        puts 'User destroyed, along with all their polls and responses'
    end

    def completed_polls
        polls_with_completion_counts.having('COUNT(DISTINCT questions.id) = COUNT(responses.id)')
    end

    def incomplete_polls
        polls_with_completion_counts.having('COUNT(DISTINCT questions.id) > COUNT(responses.id)')
        .having('COUNT(responses.id) > 0')
    end

    def completed_polls_sql
        Poll.find_by_sql(<<-SQL)
        SELECT
            polls.*
        FROM
            polls
        JOIN
            questions ON polls.id = questions.poll_id
        JOIN
            answer_choices ON answer_choices.question_id = questions.id
        LEFT OUTER JOIN (
            SELECT
                *
            FROM
                responses
            WHERE
                user_id = #{self.id}
        ) AS responses ON responses.answer_id = answer_choices.id
        GROUP BY
            polls.id 
        HAVING
            COUNT(DISTINCT questions.id) = COUNT(responses.*)
        SQL
    end

    private

    def polls_with_completion_counts
        subquery = <<-SQL
            LEFT OUTER JOIN (
            SELECT
                *
            FROM
                responses
            WHERE
                user_id = #{self.id}
        ) AS responses ON responses.answer_id = answer_choices.id
        SQL

        Poll.joins(questions: :answer_choices)
        .joins(subquery)
        .group('polls.id')
    end
end
