class Stack
    def initialize
        @array = []
    end

    def push(el)
        @array.unshift(el) 
    end

    def pop
        @array.shift
    end

    def peek
        @array[0]
    end
end

class Queue
    def initialize
        @array = []
    end

    def peek
        @array[-1]
    end

    def enqueue(el)
        @array.unshift(el)
    end

    def dequeue
        @array.pop
    end
end

class Map
    def initialize
        @array = []
    end

    def get(key)
        @array.each do |array|
            return array if array[0] == key
        end
        nil
    end

    def set(key, value)
        array = get(key)
        
        if !array
            @array << [key, value] 
        else
            array[1] = value
        end
    end

    def show
        p @array
    end

    def delete(key)
        array = get(key)
        @array.delete(array) if array != nil
    end
end

a = Map.new
a.set('a', 1)
a.set('a', 5)
a.set('b', 10)
a.set('c', 15)
a.delete('b')
a.show
