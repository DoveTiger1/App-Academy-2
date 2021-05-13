require_relative './board.rb'
require_relative './human_player.rb'

class Game
    def initialize(mark_1, mark_2)
        @player_1 = HumanPlayer.new(mark_1)
        @player_2 = HumanPlayer.new(mark_2)
        @board = Board.new
        @current_player = @player_1
    end

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

    def play
        while @board.empty_positions?
            @board.print
            position = @current_player.get_position
            @board.place_mark(position, @current_player.mark)
            if @board.win?(@current_player.mark)
                p "Congratulations! "
                p @current_player.mark
                print " has won the game!"
                return
            else
                self.switch_turn
            end
        end
        p 'There was a Draw!'
    end

end