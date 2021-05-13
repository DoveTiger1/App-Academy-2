require 'colorize'

class Tile
    def initialize(board, bomb = false, position)
        @bomb = bomb
        @revealed = false
        @flagged = false
        @board = board
        @position = position
        @neighbours = []
        @inner = true
    end

    def define_neighbours
        @neighbours = neighbours_array
        @inner = false if @neighbours.any? { |tile| tile.is_bomb?}
    end

    def flag
        @flagged = !@flagged if !revealed?
    end

    def reveal
        @revealed = !@revealed if !@revealed && !@flagged
    end

    def revealed?
        @revealed
    end

    def is_bomb?
        @bomb
    end

    def inner?
        @inner
    end

    def inspect
        "Position: #{@position}"
    end

    def to_s
        if @flagged
            return 'F'.colorize(:blue)
        elsif !@revealed
            return '*'.colorize(:white)
        elsif @revealed && !@bomb
            return tile_number
        else
            return 'B'.colorize(:red)
        end
    end

    def position
        @position
    end

    def tile_number
        return '_'.colorize(:white) if @inner
        bomb_neighbours.to_s.colorize(:yellow)
    end

    def lower_limits(current)
        return current if current == 0
        return current - 1
    end

    def upper_limits(current)
        return current if current == @board.length - 1
        return current + 1
    end

    def neighbours_array
        neighbours = []
        row = @position[0]
        rows_to_check = (lower_limits(row)..upper_limits(row))
        column = @position[1]
        columns_to_check = (lower_limits(column)..upper_limits(column))
        rows_to_check.each do |i|
            columns_to_check.each do |j|
                neighbour = @board[[i, j]]
                neighbours << neighbour if neighbour != self
            end
        end
        neighbours
    end

    def bomb_neighbours
        @neighbours.select {|ele| ele.is_bomb?}.count
    end

    def reveal_neighbours
        return if !@inner
        @neighbours.each do |tile|
            if !tile.revealed?
                if tile.inner?
                    tile.reveal
                    tile.reveal_neighbours
                else
                    tile.reveal
                end
            end
        end
    end
end