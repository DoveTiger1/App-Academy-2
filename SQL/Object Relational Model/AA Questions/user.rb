require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class User
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum)}
    end

    def self.find_by_id(id)
        begin
            data = QuestionsDatabase.instance.execute(<<-SQL, id)
                SELECT
                    *
                FROM
                    users
                WHERE
                    id = (?)
            SQL
            User.new(data[0])
        rescue
            puts "Not a valid id"
        end
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND
                lname = ?
        SQL
        data.map { |datum| User.new(datum)}
    end

    attr_accessor :id, :fname, :lname

    def initialize(data)
        @id = data['id']
        @fname = data['fname']
        @lname = data['lname']
    end

    def save
        if self.id
            update
        else
            create
        end
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_author_id(self.id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end

    def average_karma
        avg = QuestionsDatabase.instance.execute(<<-SQL, self.id)
            SELECT
                (CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id))) AS avg
            FROM
                questions
            LEFT OUTER JOIN
                question_likes ON questions.id = question_likes.question_id
            WHERE
                questions.author_id = ?
        SQL
        avg[0]['avg']
    end

    private

    def create
        raise 'Already in database!' if self.id
        QuestionsDatabase.instance.execute(<<-SQL, id, fname, lname)
            INSERT INTO
                users (fname, lname)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise 'Already in database!' unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
            UPDATE
                users
            SET
                fname = ?,
                lname = ?
            WHERE
                id = ?
        SQL
        true
    end
end