class ComputerPlayer
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position(legal)
        position = legal.sample
        p 'the computer played the position:'
        p position
        return position
    end
end