require_relative './maze_solver.rb'

class MazeReader
    MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]]

    attr_reader :start, :end

    def initialize(filename)
        @map = load_map(filename)
        @start = find_start
        @end = find_end
    end

    def possible_moves(current_location)
        possibles = []
        MOVES.each do |move|
            newmove = []
            move.each_with_index do |coordinate, i|
                newmove << coordinate + current_location[i]
            end
            possibles << newmove if !is_wall?(newmove)
        end
        possibles
    end

    def is_wall?(position)
        x,y = position
        @map[y][x] == '*'
    end

    def load_map(filename)
        maze = []
        File.open(filename).each_line do |line|
            chars = line.split(//)
            maze << chars
        end
        maze
    end

    def find_start
        find_char('S')
    end

    def find_end
        find_char('E')
    end

    def find_char(char)
        @map.each_with_index do |line, column|
            return [line.index(char), column] if line.include?(char)
        end
    end

    def to_s
        map = ''
        @map.each do |i|
            map << i.join("")
        end
        map
    end
end

if __FILE__ == $PROGRAM_NAME
    filename = ARGV[0] || "maze.txt"
    maze = MazeReader.new(filename)
    puts maze
    solver = MazeSolver.new(maze)
    solver.solve
end