require_relative './board.rb'

class Game
    def initialize(filename)
        @board = Board.from_file(filename)
        @count = 0
    end

    def play
        while !@board.won?
            @board.render
            input = get_input
            @board.updatetile(input[0..1], input[2])
            @count += 1
        end
        puts "Congratulations! you won the game with #{@count} moves!"
    end

    def get_input
        puts "Please input a tile position and value like so: row column new_value"
        input = gets.chomp.split(' ')
        input.map! {|ele| ele.to_i}
        while !valid_move?(input)
            puts 'invalid move, please try again!'
            input = gets.chomp.split(' ')
            input.map! {|ele| ele.to_i}
        end
        input
    end


    private

    def valid_move?(pos)
        row, column, value = pos
        length = (@board.grid.length - 1)
        return false if pos.length < 3 || row > length || column > length || value > 9 || value < 0
        true
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new('sudoku1.txt')
    game.play
end