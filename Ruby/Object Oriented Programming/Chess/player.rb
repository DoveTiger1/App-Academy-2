class Player
    attr_accessor :color, :display, :board

    def initialize(color, display, board)
        @color = color
        @display = display
        @board = board
        @piece_selected = []
    end

    def get_position
        input = @display.cursor.get_input
        @display.render
        print "\nCurrent Player: #{color}"
        until input != nil
            input = @display.cursor.get_input
            @display.render
            print "\nCurrent Player: #{color}"
        end
        input
    end

    
end