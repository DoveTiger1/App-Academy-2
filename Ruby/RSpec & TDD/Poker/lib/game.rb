require_relative 'deck'
require_relative 'player'

class Game
    attr_accessor :pot, :players, :current_player

    def initialize(*names)
        @deck = Deck.new
        @pot = 0
        @players = []
        create_players(names)
        @current_player = @players[0]
    end

    def inspect

    end

    def create_players(names)
        raise 'not enough players' if names.length < 3
        names.each {|name| @players << Player.new(name, self)}
    end

    def play
        setup
        
        betting_round
        unless @players.length == 1
            discard_round
            betting_round
        end

        winner = showdown
        puts "Congratulations! #{winner} won!"
    end

    def betting_round
        @players.each do |player|
            puts "#{player.name}'s Turn to bet!"
            player.betting_round
        end
    end

    def discard_round
        @players.each do |player|
            puts "#{player.name}'s Turn to discard!"
            player.discard
        end
    end

    def showdown
        scores = {}
        @players.each do |player|
            scores[player.name] = player.hand.rank
        end
        puts scores
        winner = scores.key(scores.values.max)
    end

    def setup
        @players.each do |player|
            cards = []
            5.times {|i| cards << @deck.take_card}
            cards.each {|card| player.hand.add_card(card)}
        end
    end

    def switch_player
        @players.rotate!
        @current_player = @players[0]
    end

    def raise_pot(amount)
        raise 'invalid amount' if amount <= 0
        @pot += amount
    end

    def take_card
        @deck.take_card
    end

    def player_fold(player)
        raise 'game only has one player!' if @players.length == 1
        @players.delete(player)
    end
end