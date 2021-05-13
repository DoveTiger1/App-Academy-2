class HumanPlayer
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position(legal)
        p 'the player of this turn is:'
        p @mark
        p 'Please input the row and column numbers separated by a space; any letter will be considered as a zero:'
        input = gets.chomp
        position = input.split(" ")
        position.map! {|ele| ele.to_i}
        while !legal.include?(position)
            p 'this position is invalid, please choose another one'
            input = gets.chomp
            position = input.split(" ")
            position.map! {|ele| ele.to_i}
        end
        p 'your position was'
        p position
        return position
    end
end