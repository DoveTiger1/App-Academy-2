require_relative './human_player.rb'

class Game
    def initialize(*players)
        @players = []
        players.each {|player| @players << player}
        @losses = {}
        @lost = []
        @players.each {|player| @losses[player.name] = 0}
        @current_player = @players[0]
        @fragment = ''
        @dictionary = Hash[File.read('dictionary.txt').split("\n").map{|i|i.split(', ')}]
    end

    def next_player!
        @players.rotate!
        @current_player = @players[0]
        while @lost.include?(@current_player)
            @players.rotate!
            @current_player = @players[0]
        end
    end

    def valid_play?(string)
        return false if string.length > 1 || !string.match?(/[[:alpha:]]/)
        @dictionary.each_key do |word|
            return true if word.include?(@fragment + string)
        end
        false
    end

    def lose_round?(word)
        @dictionary.has_key?(word)
    end

    def end_game?
        @lost.length == @players.length - 1
    end

    def take_turn
        input = @current_player.guess
        while !valid_play?(input)
            p 'That move is not valid, please choose another letter'
            input = gets.chomp
        end
        @fragment = @fragment + input
    end

    def record(player)
        string = 'GHOST'
        return 'LOST' if @losses[player.name] == -1
        string[0...@losses[player.name]]
    end

    def display_standings
        @players.each do |player|
            print player.name
            print ' : '
            print record(player)
            puts
        end
    end

    def lose_game?
        @losses.each_pair {|player, losses| return true if losses >= 5}
        false
    end
    
    def play_round
        @fragment = ""
        while !lose_round?(@fragment)
            self.next_player!
            puts '-----------------------'
            puts 'Current word:'
            puts @fragment
            puts 'Current player is: '
            puts @current_player.name
            self.take_turn
        end
        print @current_player.name
        print ' has lost this round! he spelled the word: '
        print @fragment
        @losses[@current_player.name] += 1
    end

    def run
        while !end_game?
            while !lose_game?
                puts
                puts 'The standings are:'
                self.display_standings
                play_round
            end
            puts "\nRound Over!"
            print @current_player.name
            print ' has lost 5 times! they are out of future rounds!'
            @lost << @current_player
            @losses[@current_player.name] = -1
        end
        puts "\n Game Over! there is only one player remaining!"
    end
end

nick = HumanPlayer.new('Nick')
john = HumanPlayer.new('John')
bob = HumanPlayer.new('Bob')

a = Game.new(nick, john, bob)
a.run
