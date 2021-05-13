class Hand
    attr_reader :cards

    def initialize
        @cards = []
    end

    def full?
        @cards.length >= 5
    end

    def add_card(card)
        raise 'hand is already full!' if full?
        @cards << card
    end

    def discard(number)
        raise 'invalid number!' if number < 0 || number >= cards.length
        card = @cards.delete_at(number)
    end

    def rank
        if straight_flush?
            return 22
        elsif four_of_a_kind?
            return 21
        elsif full_house?
            return 20
        elsif flush?
            return 19
        elsif straight?
            return 18
        elsif three_of_a_kind?
            return 17
        elsif two_pair?
            return 16
        elsif one_pair?
            return 15
        else
            high_card
        end
    end

    private

    def straight_flush?
        flush? && straight?
    end

    def four_of_a_kind?
        counts = Hash.new{0}
        @cards.each do |card|
            counts[card.rank] += 1
        end
        counts.has_value?(4)
    end

    def full_house?
        counts = Hash.new{0}
        @cards.each do |card|
            counts[card.rank] += 1
        end
        counts.has_value?(3) && counts.has_value?(2)
    end

    def flush?
        suit = @cards.first.suit
        @cards.all? { |card| card.suit == suit}
    end

    def straight?
        return false if !full?
        values = []
        @cards.each { |card| values << rank_to_number(card.rank)}

        straight = true
        
        if values.include?(14)
            values.sort!
            (0...4).each do |i|
                straight = false if values[i] != (values[i+1] - 1)
            end

            return true if straight

            straight = true

            values[-1] = 1
            values.sort!
            (0...4).each do |i|
                straight = false if values[i] != (values[i+1] - 1)
            end
        else
            values.sort!
            (0...4).each do |i|
                straight = false if values[i] != (values[i+1] - 1)
            end
        end

        straight
    end

    def three_of_a_kind?
        counts = Hash.new{0}
        @cards.each do |card|
            counts[card.rank] += 1
        end
        counts.has_value?(3)
    end

    def two_pair?
        pairs = 0
        (0...@cards.length).each do |i|
            ((i + 1)...@cards.length).each do |j|
                pairs += 1 if cards[i].rank == cards[j].rank
                return true if pairs == 2
            end
        end
        pairs == 2
    end

    def one_pair?
        (0...@cards.length).each do |i|
            ((i + 1)...@cards.length).each do |j|
                return true if cards[i].rank == cards[j].rank
            end
        end
        false
    end

    def high_card
        highest = 0
        @cards.each do |card|
            card_rank = rank_to_number(card.rank)
            highest = card_rank if card_rank > highest
        end
        highest
    end

    def rank_to_number(string)
        if string == 'Jack'
            return 11
        elsif string == 'Queen'
            return 12
        elsif string == 'King'
            return 13
        elsif string == 'Ace'
            return 14
        else
            return string.to_i
        end
    end
end