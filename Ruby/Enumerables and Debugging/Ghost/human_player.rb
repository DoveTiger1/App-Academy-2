class HumanPlayer
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess
        puts 'Enter a letter:'
        input = gets.chomp
    end
end