require_relative './list.rb'

class TodoBoard
    def initialize(*labels)
        @lists = {}
        labels.each {|label| @lists[label] = List.new(label)}
    end

    def get_command
        puts 'Enter a command:'
        cmd, *args = gets.chomp.split(' ')
        case cmd
        when 'mklist'
            if @lists.has_key?(args[0])
                raise 'already has a list with that label'
            else
                @lists[args[0]] = List.new(args[0])
            end
        when 'ls'
            p @lists.keys
        when 'showall'
            @lists.each_value {|v| v.print}
        when 'mktodo'
            @lists[args[0]].add_item(args[1], args[2], *args[3])
        when 'up'
            if args.length > 2
                @lists[args[0]].up(args[1].to_i, args[2].to_i)
            else
                @lists[args[0]].up(args[1].to_i)
            end
        when 'down'
            if args.length > 1
                @lists[args[0]].down(args[1].to_i, args[2].to_i)
            else
                @lists[args[0]].down(args[1].to_i)
            end
        when 'swap'
            @lists[args[0]].swap(args[1].to_i, args[2].to_i)
        when 'sort'
            @lists[args[0]].sort_by_date
        when 'priority'
            @lists[args[0]].print_priority
        when 'print'
            if args.length == 1
                @lists[args[0]].print
            else
                @lists[args[0]].print_full_item(args[1].to_i)
            end
        when 'toggle'
            @lists[args[0]].toggle_item(args[1].to_i)
        when 'rm'
            @lists[args[0]].remove_item(args[1].to_i)
        when 'purge'
            @lists[args[0]].purge
        when 'quit'
            return false
        else
            print 'command not recognized.'
        end
        true
    end

    def run
        running = true
        while running
            running = false if get_command == false
        end
    end
end

board = TodoBoard.new
board.run