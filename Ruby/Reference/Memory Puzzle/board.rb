require_relative './card.rb'

class Board

    def initialize(pairs)
        raise 'incorrect size' if pairs > 8 || pairs < 4 || !pairs.even?
        @pairs = pairs
        @board = Array.new(pairs/2){ Array.new(pairs/2)}
        populate
    end

    def populate
        alphabet = [*"A".."Z"]
        letters = alphabet.sample(@pairs) * 2
        @board.each_with_index do |row, i|
            row.each_with_index do |column, j|
                nextletter = letters.sample
                index = letters.index(nextletter)
                @board[i][j] = Card.new(nextletter)
                letters.delete_at(index)
            end
        end
    end

    def render
        @board.each do |i|
            print ' | '
            i.each do |j|
                print j.display
                print ' '
            end
            puts '| '
        end
    end

    def won?
        @board.each do |i|
            i.each do |j|
                return false if j.faceup == false
            end
        end
        true
    end

    def [](pos)
        row, column = pos
        @board[row][column]
    end

    def faceup?(pos)
        row, column = pos
        @board[row][column].faceup == true
    end

    def valid_move(position)
        x, y = position
        return x < @board.length && y < @board.length
    end

    def switch_card(guessed_pos)
        row, column = guessed_pos
        @board[row][column].switch 
    end
end
