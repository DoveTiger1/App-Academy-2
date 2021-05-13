class MyQueue
    def initialize
      @store = []
    end

    def enqueue(element)
        @store.push(element)
    end

    def dequeue
        @store.shift
    end

    def peek
        @store[0]
    end

    def empty?
        @store.empty?
    end

    def size
        @store.length
    end
end

class MyStack
    def initialize
      @store = []
    end

    def push(element)
        @store.push(element)
    end

    def pop
        @store.pop
    end

    def peek
        @store[-1]
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end
end

class StackQueue
    def initialize
        @in_stack = MyStack.new
        @out_stack = MyStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty
        @in_stack.empty? && @out_stack.empty?
    end

    def enqueue(element)
        @in_stack.push(element)
    end

    def dequeue
        queueify if @out_stack.empty?

        @out_stack.pop
    end

    private

    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end

class MinMaxStack
    def initialize
      @store = MyStack.new
    end
  
    def peek
      @store.peek[:value] unless empty?
    end
  
    def size
      @store.size
    end
  
    def empty?
      @store.empty?
    end
  
    def max
      @store.peek[:max] unless empty?
    end
  
    def min
      @store.peek[:min] unless empty?
    end
  
    def pop
      @store.pop[:value] unless empty?
    end
  
    def push(val)
      @store.push({max: new_max(val), min: new_min(val), value: val})
    end
  
    private
  
    def new_max(val)
      empty? ? val : [max, val].max
    end
  
    def new_min(val)
      empty? ? val : [min, val].min
    end
  end

class MinMaxStackQueue
    def initialize
        @in_stack = MinMaxStack.new
        @out_stack = MinMaxStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def max
        maxes = []
        maxes << @in_stack.max unless @in_stack.empty?
        maxes << @out_stack.max unless @out_stack.empty?
        maxes.max
    end

    def min
        mins = []
        mins << @in_stack.min unless @in_stack.empty?
        
        mins << @out_stack.min unless @out_stack.empty?
        mins.min
    end

    def empty
        @in_stack.empty? && @out_stack.empty?
    end

    def enqueue(element)
        @in_stack.push(element)
    end

    def dequeue
        queueify if @out_stack.empty?

        @out_stack.pop
    end

    private

    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end

def windowed_max_range(arr, w)
    current_max = nil
    (0...arr.length).each do |i|
        window = arr[i...(i+w)]
        min = nil
        max = nil
        window.each do |ele|
            min = ele if min.nil? || ele < min
            max = ele if max.nil? || ele > max
        end
        range = max - min
        current_max = range if current_max.nil? || current_max < range
    end
    current_max
end

def windowed_max_range_v2(arr, w)
    queue = MinMaxStackQueue.new
    best = nil

    arr.each do |ele|
        queue.enqueue(ele)
        queue.dequeue if queue.size > w

        if queue.size == w
            range = queue.max - queue.min
            best = range if best.nil? || best < range
        end
    end
    best
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
puts
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range_v2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8