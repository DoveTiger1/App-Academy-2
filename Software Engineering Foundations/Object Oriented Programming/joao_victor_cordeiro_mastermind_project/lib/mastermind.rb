require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(instance)
        puts "number of exact matches: #{@secret_code.num_exact_matches(instance)}"
        puts "number of near matches: #{@secret_code.num_near_matches(instance)}"
    end

    def ask_user_for_guess
        p 'Enter a code'
        input = gets.chomp
        input = Code.from_string(input)
        print_matches(input)
        @secret_code == input
    end
end
