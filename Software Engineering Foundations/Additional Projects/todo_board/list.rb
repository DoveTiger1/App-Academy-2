require_relative './item.rb'

class List
    attr_accessor :label

    def initialize(label)
        @items = []
        @label = label
    end

    def add_item(title, deadline, description = "")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        return false if index < 0 || index > size - 1
        true
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts "-" * 52
        puts "#{@label.upcase}".rjust(24)
        puts "-" * 52
        puts "Index  | " + "Item".ljust(20) + " | Deadline   | Done?"
        puts "-" * 52
        @items.each_with_index do |item, id|
            puts "#{id.to_s.ljust(6)} | #{item.title.to_s.ljust(20)} | #{item.deadline.to_s} | #{item.done.to_s}"
        end
        nil
    end

    def print_full_item(index)
        if valid_index?(index)
            puts "-" * 52
            puts "#{@items[index].title.to_s.ljust(30)} #{@items[index].deadline.to_s} | #{@items[index].done.to_s}"
            puts @items[index].description
            puts "-" * 52
        end
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount = 1)
        return false if !valid_index?(index)
        idx = index
        (0...amount).each do
            return true if @items[idx] == @items.first
            @items[idx], @items[idx-1] = @items[idx-1], @items[idx]
            idx -= 1
        end
        true
    end

    def down(index, amount = 1)
        return false if !valid_index?(index)
        idx = index
        (0...amount).each do
            return true if @items[idx] == @items.last
            @items[idx], @items[idx+1] = @items[idx+1], @items[idx]
            idx += 1
        end
        true
    end

    def sort_by_date
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        if valid_index?(index)
            @items[index].toggle
            return true
        else
            return false
        end
    end

    def remove_item(index)
        if valid_index?(index)
            @items.delete_at(index)
            return true
        else
            return false
        end
    end

    def purge
        @items.delete_if {|item| item.done == true}
    end
end