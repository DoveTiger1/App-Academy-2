require_relative './maze_reader.rb'

class MazeSolver
    def initialize(maze)
        @maze = maze
        reset
    end

    def reset
        @branching_paths = {}
        @current = @maze.find_start
    end

    def solve
        build_branching_paths
        path = find_path
        p path
    end

    def find_distance(point)
        px, py = point
        finalx, finaly = @maze.find_end
        ((px - finalx) + (py - finaly)).abs
    end

    def find_manhattan_estimate(point)
        distance_end = find_distance(point)
        distance_travelled = find_path(point).length
        f = distance_end + distance_travelled
    end

    def manhattan_heuristic(queue)
        queue.inject do |chosen, point|
            old_f = find_manhattan_estimate(chosen)
            new_f = find_manhattan_estimate(point)
            old_f > new_f ? point : chosen
        end
    end

    def build_branching_paths(heuristic = :manhattan_heuristic)
        reset
        queue = [@current]
        visited = [@current]

        until queue.empty? || @current == @maze.find_end
            @current = self.send(heuristic, queue)
            queue.delete(@current)
            visited << @current
            nearby_openings = @maze.possible_moves(@current)
            nearby_openings.each do |point|
                unless visited.include?(point) || queue.include?(point)
                    queue << point
                    @branching_paths[point] = @current
                end
            end
        end

        @branching_paths
        
    end

    def find_path(goal = @maze.find_end)
        path = [goal]
        spot = goal
        until @branching_paths[spot] == nil
          path << @branching_paths[spot] 
          spot = @branching_paths[spot]
        end
        path
      end

    
end