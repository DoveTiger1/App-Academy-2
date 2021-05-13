require_relative './tile.rb'

class Board
    attr_reader :grid

    def initialize(grid)
        @grid = grid
    end

    def self.from_file(filename)
        grid = []
        file = File.open(filename).each_line do |line|
            row = []
            line.chomp.each_char do |char|
                row << Tile.new(char.to_i)
            end
            grid << row
        end
        self.new(grid)
    end

    def render
        puts "\n   #{(0...@grid.length).to_a.join(' ')}"
        @grid.each_with_index do |row, i|
            print "#{i} |"
            row.each do |number|
                print "#{number} "
            end
            print "|\n"
        end
    end

    def updatetile(pos, value)
        self[pos] = value
    end

    def won?
        won_rows && won_columns
    end

    private

    def won_rows
        @grid.each do |row|
            already = Hash.new{0}
            row.each do |tile|
                return false if tile.value == 0
                already[tile.value] += 1
            end
            return false if already.any?{|tile, occurrences| occurrences > 1}
        end
        true
    end

    def won_columns
        @grid.each_with_index do |row, i|
            already = Hash.new{0}
            row.each_with_index do |column, j|
                tile = @grid[j][i]
                already[tile.value] += 1
            end
            return false if already.any?{|tile, occurrences| occurrences > 1}
        end
        true
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col].value = value
    end
end