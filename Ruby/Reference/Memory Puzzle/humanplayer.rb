class HumanPlayer
    def initialize
        @previous_guess = nil
    end

    def prompt
        puts 'Enter a position like this: row column'
        posstring = gets.chomp!
        pos = posstring.split(' ')
        pos.map!{|ele| ele.to_i}
    end

    def receive_match
    end

    def receive_revealed_card
    end
end