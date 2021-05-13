require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        system("clear")
        board.rows.each_with_index do |row, i|
            print "  |".colorize(:blue)
            row.each_with_index do |column, j|
                if [i, j] == cursor.cursor_pos
                    print "#{column} ".colorize(:color => :red, :background => :green)
                elsif column.selected
                    print "#{column} ".colorize(:color => :yellow, :background => :green)
                else
                    print "#{column} "
                end
            end
            print "|\n".colorize(:blue)
        end
    end
end

