class Board
    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n*n
    end

    def [](indices)
        @grid[indices[0]][indices[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        total = 0
        @grid.each do |array|
            count = array.count {|ele| ele == :S}
            total += count
        end
        total
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            p 'you sunk my battleship!'
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        max_random = @size * 0.25
        while self.num_ships < max_random
            random_row = rand(0...@grid.length)
            random_column = rand(0...@grid.length)
            @grid[random_row][random_column] = :S
        end
    end

    def hidden_ships_grid
        @grid.map do |array|
            array.map do |ele|
                if ele == :S
                    :N
                else
                    ele
                end
            end
        end
    end

    def self.print_grid(array)
        array.each {|row| puts row.join(" ")}
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
