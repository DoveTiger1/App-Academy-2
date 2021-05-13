require 'singleton'
require 'colorize'

module Slideable
    HORIZONTAL_AND_VERTICAL_DIRS = [
        [-1, 0],
        [0, -1],
        [0, 1],
        [1, 0]
    ].freeze
    
    DIAGONAL_DIRS = [
        [-1, -1],
        [-1, 1],
        [1, -1],
        [1, 1]
    ].freeze

    def horizontal_and_vertical_dirs
        HORIZONTAL_AND_VERTICAL_DIRS
    end
    
    def diagonal_dirs
        DIAGONAL_DIRS
    end


    def moves
        moves = []

        move_dirs.each do |dx, dy|
            moves.concat(grow_unblocked_moves_in_dir(dx, dy))
        end

        moves
    end

    private

    def move_dirs
        raise NotImplementedError
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        cur_x, cur_y = position
        moves = []

        loop do
            cur_x, cur_y = cur_x + dx, cur_y + dy
            pos = [cur_x, cur_y]
            
            break unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            else
                moves << pos if board[pos].color != self.color
                break
            end
        end
        moves
    end

end

module Stepable

    def moves
        moves = []
        move_diffs.each do |move_diff|
            cur_x, cur_y = position
            dx, dy = move_diff[0], move_diff[1]
            newposition = [cur_x + dx, cur_y + dy]
            moves << newposition if board.valid_pos?(newposition) && board[newposition].color != self.color
        end
        moves
    end

    def move_diffs
        raise NotImplementedError
    end

end

class Piece
    attr_reader :color, :symbol, :selected
    attr_accessor :position, :board

    def initialize(color, board, position)
        @color = color
        @board = board
        @position = position
        @selected = false
    end

    def select
        @selected = !@selected
    end

    def to_s
        color == 'white' ? symbol.colorize(:white) : symbol.colorize(:light_black)
    end
    
    def inspect
        color == 'white' ? symbol.colorize(:white) : symbol.colorize(:light_black)
    end

    def valid_moves
        moves.select { |move| !move_into_check?(move)}
    end

    def move_into_check?(end_pos)
        dup_board = board.dup
        dup_board.move_piece!(position, end_pos, color)
        dup_board.in_check?(color)
    end
end

class NullPiece < Piece

    include Singleton

    def initialize
        
    end

    def inspect
        " "
    end

    def select
        raise 'not a piece to select!'
    end

    def to_s
        " "
    end

    def moves

    end
end

class Rook < Piece
    include Slideable

    def initialize(color, board, position)
        super
        @symbol = '♜'
    end

    def move_dirs
        horizontal_and_vertical_dirs
    end
end

class Bishop < Piece
    include Slideable

    def initialize(color, board, position)
        super
        @symbol = '♝'
    end

    def move_dirs
        diagonal_dirs
    end
end

class Queen < Piece
    include Slideable

    def initialize(color, board, position)
        super
        @symbol = '♛'
    end

    def move_dirs
        diagonal_dirs + horizontal_and_vertical_dirs
    end
end

class Knight < Piece
    include Stepable

    def initialize(color, board, position)
        super
        @symbol = '♞'
    end

    def move_diffs
        [[-2, -1],
         [-1, -2],
         [-2, 1],
         [-1, 2],
         [1, -2],
         [2, -1],
         [1, 2],
         [2, 1]]
    end
end

class King < Piece
    include Stepable

    def initialize(color, board, position)
        super
        @symbol = '♚'
    end

    def move_diffs
        [[-1, -1],
        [-1, 0],
        [-1, 1],
        [0, -1],
        [0, 1],
        [1, -1],
        [1, 0],
        [1, 1]]
    end
end

class Pawn < Piece
    def initialize(color, board, position)
        super
        @symbol = '♟'
    end

    def moves
        moves = []
        cur_x, cur_y = position
        forward_move = [cur_x + forward_dir, cur_y]
        moves << forward_move if board.empty?(forward_move)
        if at_start_row?
            forward_double = [cur_x + forward_dir * 2, cur_y] 
            moves << forward_double
        end
        moves.concat(side_attacks) if !side_attacks.empty?
        moves
    end

    def forward_dir
        color == 'white' ? 1 : -1
    end

    def at_start_row?
        return true if (color == 'white' && position[0] == 1) || (color == 'black' && position[0] == 6)
        false
    end

    def side_attacks
        cur_x, cur_y = position

        attack_left = [cur_x + forward_dir, cur_y - 1]
        attack_right = [cur_x + forward_dir, cur_y + 1]

        possible_attacks = []
        possible_attacks << attack_left if board.valid_pos?(attack_left) && !board.empty?(attack_left) && board[attack_left].color != self.color
        possible_attacks << attack_right if board.valid_pos?(attack_right) && !board.empty?(attack_right) && board[attack_right].color != self.color
        possible_attacks
    end
end