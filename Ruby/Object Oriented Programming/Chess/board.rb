require_relative 'piece'


class Board
    attr_accessor :rows

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        setup_board
    end

    def empty?(pos)
        row, column = pos
        @rows[row][column].is_a?(NullPiece)
    end

    def valid_pos?(pos)
        row, column = pos
        return false if row > 7 || row < 0 || column > 7 || column < 0
        true
    end

    def setup_board
        piece_rows = [0, 1, 6, 7]
        rows.each_with_index do |row, i|
            if piece_rows.include?(i)
                if i == 1
                    (0..7).each { |j| rows[i][j] = Pawn.new('white', self, [i,j])}
                elsif i == 6
                    (0..7).each { |j| rows[i][j] = Pawn.new('black', self, [i,j])}
                elsif i == 0
                    rows[i][0] = Rook.new('white', self, [i, 0])
                    rows[i][1] = Knight.new('white', self, [i, 1])
                    rows[i][2] = Bishop.new('white', self, [i, 2])
                    rows[i][3] = Queen.new('white', self, [i, 3])
                    rows[i][4] = King.new('white', self, [i, 4])
                    rows[i][5] = Bishop.new('white', self, [i, 5])
                    rows[i][6] = Knight.new('white', self, [i, 6])
                    rows[i][7] = Rook.new('white', self, [i, 7])
                elsif i == 7
                    rows[i][0] = Rook.new('black', self, [i, 0])
                    rows[i][1] = Knight.new('black', self, [i, 1])
                    rows[i][2] = Bishop.new('black', self, [i, 2])
                    rows[i][3] = Queen.new('black', self, [i, 3])
                    rows[i][4] = King.new('black', self, [i, 4])
                    rows[i][5] = Bishop.new('black', self, [i, 5])
                    rows[i][6] = Knight.new('black', self, [i, 6])
                    rows[i][7] = Rook.new('black', self, [i, 7])
                end
            else
                (0..7).each { |j| rows[i][j] = NullPiece.instance}
            end
        end
    end

    def [](pos)
        row, column = pos
        rows[row][column]
    end

    def move_piece(start_pos, end_pos, player_color)
        start_row, start_column = start_pos
        end_row, end_column = end_pos
        raise ArgumentError.new("not a valid start position") if start_pos.nil? || !valid_pos?(start_pos)
        raise ArgumentError.new("not a valid end position") if end_pos.nil? || !valid_pos?(end_pos)
        

        piece = rows[start_row][start_column]

        raise ArgumentError.new("this is not your piece!") if piece.color != player_color
        
        if piece.valid_moves.include?(end_pos)
            rows[end_row][end_column] = piece
            piece.position = [end_row, end_column]
            rows[start_row][start_column] = NullPiece.instance
        else
            raise ArgumentError.new("Not a valid move!")
        end
    end

    def in_check?(color)
        king_position = find_king(color)
        other_color = color == 'white' ? 'black' : 'white'
        other_possible_moves = all_pieces_moves(other_color)
        return other_possible_moves.include?(king_position)
    end

    def find_king(color)
        rows.each_with_index do |row, i|
            row.each_with_index do |piece, j|
                return [i,j] if piece.is_a?(King) && piece.color == color
            end
        end
    end

    def all_pieces_moves(color)
        moves = []
        rows.each_with_index do |row, i|
            row.each_with_index do |piece, j|
                moves.concat(piece.moves) if piece.color == color
            end
        end
        
        moves
    end

    def checkmate?(color)
        in_check?(color) && all_pieces_moves(color).empty?
    end

    def inspect
        
    end

    def dup
        newboard = Board.new
        rows.each_with_index do |row, i|
            row.each_with_index do |column, j|
                if !column.is_a?(NullPiece)
                    newboard.rows[i][j] = column.dup 
                else
                    newboard.rows[i][j] = NullPiece.instance
                end
                newboard.rows[i][j].board = newboard
            end
        end
        newboard
    end

    def move_piece!(start_pos, end_pos, player_color)
        start_row, start_column = start_pos
        end_row, end_column = end_pos
        raise ArgumentError.new("not a valid start position") if start_pos.nil? || !valid_pos?(start_pos)
        raise ArgumentError.new("not a valid end position") if end_pos.nil? || !valid_pos?(end_pos)
        

        piece = rows[start_row][start_column]

        raise ArgumentError.new("this is not your piece!") if piece.color != player_color

        if piece.moves.include?(end_pos)
            rows[end_row][end_column] = piece
            piece.position = [end_row, end_column]
            rows[start_row][start_column] = NullPiece.instance
        else
            raise ArgumentError.new("Not a valid move!")
        end
    end
end