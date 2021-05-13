class Card
    attr_reader :value, :faceup

    def initialize(value)
        @value = value
        @faceup = false
    end

    def display
        if @faceup
            print @value
        else
            print ' '
        end
    end

    def switch
        @faceup = !@faceup
    end

    def ==(card)
        return @value == card.value
    end
end
