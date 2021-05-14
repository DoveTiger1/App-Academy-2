require_relative 'user'
require_relative 'question'

class Reply
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        begin
            data = QuestionsDatabase.instance.execute(<<-SQL, id)
                SELECT
                    *
                FROM
                    replies
                WHERE
                    id = (?)
            SQL
            Reply.new(data[0])
        rescue
            puts "Not a valid id"
        end
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                replies
            WHERE
                author_id = (?)
        SQL
        data.map { |datum| Reply.new(datum)}
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = (?)
        SQL
        data.map { |datum| Reply.new(datum)}
    end

    attr_accessor :id, :body, :parent_id, :author_id, :question_id

    def initialize(data)
        @id = data['id']
        @body = data['body']
        @parent_id = data['parent_id']
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

    def author
        User.find_by_id(self.author_id)
    end

    def question
        Question.find_by_id(self.question_id)
    end

    def parent_reply
        Reply.find_by_id(self.parent_id)
    end

    def child_replies
        children = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_id = ?
        SQL
        children.map { |child| Reply.new(child)}
    end

    private

    def create
        raise 'Already in database!' if self.id
        QuestionsDatabase.instance.execute(<<-SQL, body, parent_id, author_id, question_id)
            INSERT INTO
                replies (body, parent_id, author_id, question_id)
            VALUES
                (?, ?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise 'Not in database yet!' unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, body, parent_id, author_id, question_id, id)
            UPDATE
                replies
            SET
                body = ?,
                parent_id = ?,
                author_id = ?,
                question_id = ?
            WHERE
                id = ?
        SQL
        true
    end
end