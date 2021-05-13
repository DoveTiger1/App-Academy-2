require_relative './board.rb'
require 'yaml'

class Minesweeper
    def initialize
        @board = Board.new
    end

    def menu
        puts "Input 'n' if you want to play a new game or 'l' if you want to load the previous game"
        input_menu == 'n' ? play : load_game
    end

    def input_menu
        input = gets.chomp.split('')
        unless input.length == 1 && (input[0] !=  'n' || input[0] != 'l')
            puts "invalid input, please try again"
            input = gets.chomp.split('')
        end
        input[0]
    end

    def load_game
        @board = YAML.load(File.read("save.yml"))
        play
    end

    def play
        until @board.over?
            @board.render
            @board.action(get_input)
        end
        @board.render
        if @board.lost?
            puts 'too bad, you lost'
        else
            puts 'congratulations, you won!'
        end

    end

    def get_input
        puts "input an 'r' to reveal or 'f' to flag, followed by the position like so: 'row column', or input 's' to save game"
        input = gets.chomp.split(' ')
        while !valid_input?(input)
            puts 'invalid input, please try again.'
            input = gets.chomp.split(' ')
        end
        input[1] = input[1].to_i
        input[2] = input[2].to_i
        input
    end

    def valid_input?(input)
        return false if input.length > 3
        valid_letters = 'rfsl'
        return false if !valid_letters.include?(input[0])
        board_length = @board.length - 1
        return false if input[1].to_i > board_length || input[2].to_i > board_length
        true
    end

end

if __FILE__ == $PROGRAM_NAME
    game = Minesweeper.new
    game.menu
end