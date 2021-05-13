class Hanoi
    attr_accessor :stacks

    def initialize
        @stacks = Array.new(3) {Array.new}
        fill_stacks
    end

    def fill_stacks
        stacks[0] = [1, 2, 3] 
    end

    def play
        until won?
            render
            get_input_and_move
        end
        puts "Congratulations! you won!"
    end

    def get_input_and_move
        begin
            start_stack, end_stack = get_input
            move(start_stack, end_stack)
        rescue => e
            puts e
            retry
        end
    end

    def get_input
        puts "Input your move like this: start_tower end_tower"
        input = gets.chomp.split(" ")
        input.map! {|ele| ele.to_i}
    end

    def won?
        return false unless stacks[0].empty? && stacks[1].empty? && stacks[2] == stacks[2].sort
        true
    end

    def move(start_stack, end_stack)
        raise 'invalid move!' if stacks[start_stack].empty?
        raise 'invalid move!' unless stacks[end_stack].first.nil? || stacks[end_stack].first > stacks[start_stack].first 
        stacks[end_stack].unshift(stacks[start_stack].shift)
    end

    def render
        puts "Tower 0: #{stacks[0]}, Tower 1: #{stacks[1]}, Tower 2: #{stacks[2]}"
    end
end