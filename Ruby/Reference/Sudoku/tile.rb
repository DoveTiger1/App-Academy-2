require 'colorize'

class Tile
    attr_reader :value

    def initialize(number)
        @value = number
        @given = number > 0 ? true : false
    end

    def value=(newvalue)
        puts "\ncant change this value!" if @given
        @value = newvalue if !@given
    end

    def color
        @given? :blue : :white
    end

    def to_s
        value > 0 ? value.to_s.colorize(color) : ' '
    end
end