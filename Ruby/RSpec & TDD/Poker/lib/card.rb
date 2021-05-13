require 'colorize'

class Card
    attr_reader :suit, :rank

    def initialize(suit, rank)
        @suit = suit
        @rank = rank
    end

    def inspect
        "#{color(suit)} #{rank}"
    end

    def to_s
        "#{color(suit)} #{rank}"
    end

    def color(suit)
        if suit == 'Clubs' || suit == 'Spades'
            suit.colorize(:light_black)
        else
            suit.colorize(:light_red)
        end
    end
end