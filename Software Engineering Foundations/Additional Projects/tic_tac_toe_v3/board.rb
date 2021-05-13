class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, '_')}
        @filled_spots = 0
    end

    def valid?(position)
        position.each { |i| return false if i > (@grid.length) - 1 || i < 0}
        true
    end

    def empty?(position)
        raise 'not a valid position' if !valid?(position)
        @grid[position[0]][position[1]] == '_' if valid?(position)
    end

    def place_mark(position, mark)
        raise 'the spot is already marked' if !empty?(position)
        @grid[position[0]][position[1]] = mark if empty?(position)
        @filled_spots += 1
    end

    def print
        @grid.each do |row|
            p row
            puts
        end
    end

    def win_row?(mark)
        @grid.each do |row|
            return true if row.all? {|ele| ele == mark}
        end
        false
    end

    def win_col?(mark)
        (0..@grid.length-1).each do |i|
            samecolumn = true
            (0...@grid.length).each do |j|
                samecolumn = false if @grid[j][i] != mark
            end
            return samecolumn if samecolumn == true
        end
        false
    end

    def win_diagonal?(mark)
        same = true
        (0...@grid.length).each do |i|
            same = false if @grid[i][i] != mark
        end
        return true if same
        same = true
        (0...@grid.length).each do |i|
            same = false if @grid[i][(@grid.length - 1) - i] != mark
        end
        same
    end

    def win?(mark)
        return true if win_diagonal?(mark) || win_row?(mark) || win_col?(mark)
        false
    end

    def empty_positions?
        @filled_spots < (@grid.length * @grid.length)
    end

    def legal_positions
        positions = []
        (0...@grid.length).each do |i|
            (0...@grid.length).each do |j|
                positions << [i, j] if self.empty?([i, j])
            end
        end
        positions
    end
end