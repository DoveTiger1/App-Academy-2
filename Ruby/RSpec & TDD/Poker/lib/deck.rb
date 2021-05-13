require_relative 'card'

class Deck
    attr_accessor :cards

    def initialize
        @cards = []
        fill_with_cards
        shuffle
    end

    def fill_with_cards
        suits = %w[Clubs Diamonds Hearts Spades]
        ranks = %w[Ace 2 3 4 5 6 7 8 9 10 Jack Queen King]
        suits.each do |suit|
            ranks.each do |rank|
                @cards << Card.new(suit, rank)
            end
        end
    end

    def shuffle
        @cards.shuffle!
    end

    def take_card
        raise 'deck is empty!' if @cards.empty?
        @cards.shift
    end
end