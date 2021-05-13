require_relative './board.rb'
require_relative './humanplayer.rb'
require_relative './computerplayer.rb'

class Game
    def initialize(size = 8)
        @board = Board.new(size)
        @previously_played = []
        @counter = 0
        @player = ComputerPlayer.new(size)
    end

    def play
        while !@board.won?
            refresh
            make_guess(prompt)
        end
        refresh
        puts 'Congratulations! You won with '
        print @counter
        print ' moves! try to do better next time!'
    end

    def refresh
        system("clear")
        @board.render
    end

    def prompt
        pos = @player.prompt
        while pos.length > 2 || !@board.valid_move(pos) || @board.faceup?(pos)
            puts 'invalid move, please try again: '
            pos = @player.prompt
        end
        pos
    end

    def make_guess(pos)
        guessed_pos = pos
        if @previously_played.empty?
            @board.switch_card(guessed_pos)
            @previously_played = guessed_pos
            @player.previous_guess = guessed_pos
        else
            @board.switch_card(guessed_pos)
            if @board[guessed_pos] == @board[@previously_played]
                @player.receive_match(guessed_pos, @previously_played)
            else
                refresh
                sleep(1)
                @board.switch_card(@previously_played)
                @board.switch_card(guessed_pos)
            end
            @previously_played = []
            @player.previous_guess = []
        end
        @player.receive_revealed_card(pos, @board[pos].value)
        @counter += 1
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new()
    game.play
end