require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
    attr_reader :current_player, :board

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = [Player.new('white', @display, @board), Player.new('black', @display, @board)]
        @current_player = @players[0]
        @piece_selected = false
    end

    def play
        until @board.checkmate?('white') || @board.checkmate?('black')
            @display.render
            print "\nCurrent Player: #{current_player.color}"
            make_move
            swap_turn!
        end
        puts "Game Over!"
        if @board.checkmate?('white')
            puts "Congratulations, the black player won!"
        else
            puts "Congratulations, the white player won!"
        end
    end

    def make_move
        begin
            start_pos = current_player.get_position
            toggle_selected(start_pos)
            end_pos = current_player.get_position
            board.move_piece(start_pos, end_pos, current_player.color)
        rescue ArgumentError => e
            puts "\n#{e}"
            puts "Please try again"
            retry
        end
        @piece_selected = !@piece_selected
        toggle_selected(end_pos)
    end
    
    def toggle_selected(position)
        board[position].select if !board[position].is_a?(NullPiece) && !@piece_selected
        @piece_selected = !@piece_selected
    end

    def swap_turn!
        if @current_player == @players[0]
            @current_player = @players[1]
        else
            @current_player = @players[0]
        end
    end
end