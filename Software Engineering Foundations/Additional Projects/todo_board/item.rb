class Item
    attr_accessor :title, :description
    attr_reader :deadline, :done

    def self.valid_date?(date)
        array = date.split("-")
        return false if array[0].length >4
        return false if array[1].to_i < 1 || array[1].to_i > 12
        return false if array[2].to_i < 1 || array[2].to_i > 31
        true
    end

    def initialize(title, deadline, description)
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise 'not a valid date'
        end
        @title = title
        @description = description
        @done = false
    end

    def deadline=(new)
        if Item.valid_date?(new)
            @deadline = new
        else
            raise 'not a valid date'
        end
    end

    def toggle
        if @done == false
            @done = true
        else
            @done = false
        end
    end
end