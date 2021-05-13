class ComputerPlayer
    attr_accessor :previous_guess

    def initialize(boardsize)
        @boardsize = boardsize/2
        @known_cards = {}
        @matched_cards = {}
        @previous_guess = nil
    end

    def prompt
        if previous_guess
            second_guess
        else
            first_guess
        end
    end

    def first_guess
        unmatched_pos || random_guess
    end

    def second_guess
        match_previous || random_guess
    end

    def unmatched_pos
        (pos, _) = @known_cards.find do |pos, val|
            @known_cards.any? do |pos2, val2|
              (pos != pos2 && val == val2) &&
                !(@matched_cards[pos] || @matched_cards[pos2])
            end
        end
      
        pos
    end

    def match_previous
        (pos, _) = @known_cards.find do |pos, val|
            pos != previous_guess && val == @known_cards[previous_guess] && !@matched_cards[pos]
        end
        
        pos
    end

    def receive_match(pos1, pos2)
        @matched_cards[pos1] = true
        @matched_cards[pos2] = true
    end

    def receive_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    def random_guess
        guess = nil

        until guess != nil && !@known_cards[guess]
            guess = [rand(@boardsize), rand(@boardsize)]
        end

        guess
    end
end