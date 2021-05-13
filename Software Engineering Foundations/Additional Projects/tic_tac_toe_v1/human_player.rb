class HumanPlayer
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position
        p 'The player of this turn is:'
        p @mark
        p 'Please input the row and column numbers separated by a space; any letter will be considered as a zero:'
        input = gets.chomp
        position = input.split(" ")
        position.map! {|ele| ele.to_i}
        raise 'incorrect input' if position.length > 2
        p 'your position was'
        p position
        return position
    end
end