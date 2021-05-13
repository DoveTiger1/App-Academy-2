require_relative 'treenode.rb'

class KnightPathFinder
    attr_accessor :root_node

    MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
      ]

    def initialize(start)
        @start = start
        @considered_positions = [start]
        build_move_tree
    end

    def self.valid_moves(pos)
        valid_moves = []

        cur_x, cur_y = pos
        MOVES.each do |(dx, dy)|
        new_pos = [cur_x + dx, cur_y + dy]

        if new_pos.all? { |coord| coord.between?(0, 7) }
            valid_moves << new_pos
        end
    end

    valid_moves
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos).reject {|new_pos| @considered_positions.include?(new_pos)}.each { |new_pos| @considered_positions << new_pos }
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@start)

        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |move|
                next_node = PolyTreeNode.new(move)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def find_path(end_pos)
        end_root = self.root_node.dfs(end_pos)
        trace_back_path(end_root).reverse
    end

    def trace_back_path(end_root)
        moves = []
        until end_root == self.root_node
            moves << end_root
            end_root = end_root.parent
        end
        moves << self.root_node
        moves
    end
end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
    p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end