require_relative 'reply'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'

class Question
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end

    def self.find_by_id(id)
        begin
            data = QuestionsDatabase.instance.execute(<<-SQL, id)
                SELECT
                    *
                FROM
                    questions
                WHERE
                    id = (?)
            SQL
            Question.new(data[0])
        rescue
            puts "Not a valid id"
        end
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = (?)
        SQL
        data.map { |datum| Question.new(datum)}
    end

    def self.most_followed(n = 5)
        QuestionFollow.most_followed_questions(n)
    end
    
    def self.most_liked(n = 5)
        QuestionLike.most_liked_questions(n)
    end

    attr_accessor :id, :title, :body, :author_id

    def initialize(data = {})
        @id = data['id']
        @title = data['title']
        @body = data['body']
        @author_id = data['author_id']
    end

    def save
        if self.id
            update
        else
            create
        end
    end

    def author
        User.find_by_id(self.author_id)
    end

    def replies
        Reply.find_by_question_id(self.id)
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end

    def likers
        QuestionLike.likers_for_question_id(self.id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(self.id)
    end

    private

    def create
        raise 'Already in database!' if self.id
        QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
            INSERT INTO
                questions (title, body, author_id)
            VALUES
                (?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise 'Not in database yet!' unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id, id)
            UPDATE
                questions
            SET
                title = ?,
                body = ?,
                author_id = ?
            WHERE
                id = ?
        SQL
        true
    end
end