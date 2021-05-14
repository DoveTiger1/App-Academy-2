class QuestionLike
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLike.new(datum)}
    end

    def self.find_by_id(id)
        begin
            data = QuestionsDatabase.instance.execute(<<-SQL, id)
                SELECT
                    *
                FROM
                    question_likes
                WHERE
                    id = (?)
            SQL
            QuestionLike.new(data[0])
        rescue
            puts "Not a valid id"
        end
    end

    def self.likers_for_question_id(question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_likes ON question_likes.author_id = users.id
            WHERE
                question_likes.question_id = ?
        SQL
        likers.map { |liker| User.new(liker)}
    end

    def self.num_likes_for_question_id(question_id)
        count = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                COUNT(*)
            FROM
                users
            JOIN
                question_likes ON question_likes.author_id = users.id
            WHERE
                question_likes.question_id = ?
        SQL
        count[0]['COUNT(*)']
    end

    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes ON question_likes.question_id = questions.id
            WHERE
                question_likes.author_id = ?
        SQL
        questions.map { |question| Question.new(question)}
    end

    def self.most_liked_questions(n = 5)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes ON questions.id = question_likes.question_id
            GROUP BY
                question_likes.question_id
            ORDER BY
                COUNT(question_likes.question_id) DESC
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
        QuestionsDatabase.instance.execute(<<-SQL, id, author_id, question_id)
            INSERT INTO
                question_likes (author_id, question_id)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise 'Already in database!' unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, author_id, question_id, id)
            UPDATE
                question_likes
            SET
                author_id = ?,
                question_id = ?
            WHERE
                id = ?
        SQL
        true
    end
end