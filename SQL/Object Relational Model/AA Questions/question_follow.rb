class QuestionFollow
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| QuestionFollow.new(datum)}
    end

    def self.find_by_id(id)
        begin
            data = QuestionsDatabase.instance.execute(<<-SQL, id)
                SELECT
                    *
                FROM
                    question_follows
                WHERE
                    id = (?)
            SQL
            QuestionFollow.new(data[0])
        rescue
            puts "Not a valid id"
        end
    end

    def self.followers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_follows ON users.id = question_follows.author_id
            WHERE
                question_follows.question_id = ?
        SQL
        users.map { |user| User.new(user)}
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows ON questions.id = question_follows.question_id
            WHERE
                question_follows.author_id = ?
        SQL
        questions.map { |question| Question.new(question)}
    end

    def self.most_followed_questions(n = 5)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows ON questions.id = question_follows.question_id
            GROUP BY
                question_follows.question_id
            ORDER BY
                COUNT(question_follows.question_id) DESC
            LIMIT(?)
        SQL
        questions.map { |question| Question.new(question)}
    end

    attr_accessor :id, :author_id, :question_id

    def initialize(data)
        @id = data['id']
        @author_id = data['author_id']
        @question_id = data['question_id']
    end

    def save
        if self.id
            update
        else
            create
        end
    end

    private

    def create
        raise 'Already in database!' if self.id
        QuestionsDatabase.instance.execute(<<-SQL, author_id, question_id)
            INSERT INTO
                question_follows (author_id, question_id)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise 'Already in database!' unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, author_id, question_id, id)
            UPDATE
                question_follows
            SET
                author_id = ?,
                question_id = ?
            WHERE
                id = ?
        SQL
        true
    end
end