require_relative './tile.rb'
require 'yaml'

class Board

    def initialize(size = 1)
        @grid = newgrid(size)
        @grid = place_bombs(@grid)
        update_tiles
        @bomb_free_squares = bomb_free_squares
    end

    def update_tiles
        @grid.each_with_index do |row, i|
            row.each_with_index do |column, j|
                @grid[i][j].define_neighbours
            end
        end
    end

    def newgrid(size)
        if size == 1
            newgrid = Array.new(9) {Array.new(9)}
        end
    end

    def [](pos)
        row, column = pos
        @grid[row][column]
    end

    def place_bombs(grid)
        newgrid = []
        grid.each_with_index do |row, i|
            newrow = []
            row.each_with_index do |element, j|
                newrow << Tile.new(self, random_boolean, [i, j])
            end
            newgrid << newrow
        end
        newgrid
    end

    def random_boolean
        (0..4).to_a.sample == 1 ? true : false
    end

    def render
        puts "\n    #{(0...@grid.length).to_a.join(' ')}"
        @grid.each_with_index do |row, i|
            print "#{i} | "
            row.each do |element|
                print "#{element} "
            end
            print "|\n"
        end
    end

    def action(input)
        action, row, column = input
        if action == 'f'
            @grid[row][column].flag
        elsif action == 'r'
            @grid[row][column].reveal
            @grid[row][column].reveal_neighbours
        elsif action == 's'
            save_board
        end
    end

    def length
        @grid.length
    end
    
    def over?
        won? || lost?
    end

    def bomb_free_squares
        count = 0
        @grid.each do |row|
            row.each do |tile|
                count += 1 if !tile.is_bomb?
            end
        end
        count
    end

    def won?
        tiles = 0
        @grid.each do |row|
            row.each do |element|
                tiles += 1 if element.revealed? && !element.is_bomb?
            end
        end
        tiles == @bomb_free_squares
    end

    def lost?
        @grid.each do |row|
            row.each do |element|
                return true if element.is_bomb? && element.revealed?
            end
        end
        false
    end

    def save_board
        File.open("save.yml", "w") { |file| file.write(self.to_yaml) }
    end

end
