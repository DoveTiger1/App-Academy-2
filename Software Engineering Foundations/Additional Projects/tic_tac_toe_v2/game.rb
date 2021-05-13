require_relative './board.rb'
require_relative './human_player.rb'

class Game
    def initialize(size, *marks)
        @players = []
        marks.each {|mark| @players << HumanPlayer.new(mark)}
        @board = Board.new(size)
        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!
        @current_player = @players[0]
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