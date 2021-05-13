class Array
    def my_each(&prc)
        self.length.times do |i|
            prc.call(self[i])
        end

        self
    end

    def my_select(&prc)
        newarr = []

        self.my_each do |ele|
            newarr << ele if prc.call(ele) 
        end

        newarr
    end

    def my_reject(&prc)
        newarr = []

        self.my_each do |ele|
            newarr << ele unless prc.call(ele)
        end

        newarr
    end

    def my_any?(&prc)
        self.my_each do |ele|
            return true if prc.call(ele) == true
        end

        false
    end

    def my_all?(&prc)
        self.my_each do |ele|
            return false if prc.call(ele) == false    
        end

        true
    end

    def my_flatten
        flattened = []

        self.my_each do |ele|
            if ele.is_a?(Array)
                flattened.concat(ele.my_flatten)
            else
                flattened << ele
            end
        end

        flattened
    end

    def my_zip(*arrays)
        finalarr = []
        self.length.times do |i|
            newarr = []
            newarr << self[i]
            arrays.each do |array|
                newarr << array[i]
            end
            finalarr << newarr
        end
        finalarr
    end

    def my_rotate(num = 1)
        start = num % self.length
        newarr = self[start..-1] + self[0...start]
    end

    def my_join(separator = '')
        newstr = ''
        self.my_each do |ele|
            newstr += ele
            newstr += separator if ele != self.last
        end
        newstr
    end

    def my_reverse
        my_rotate(self.length-1)
    end
end

return_value = [1, 2, 3].my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end
  # => 1
       2
       3
       1
       2
       3
  
p return_value  # => [1, 2, 3]

p 'my select: '

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

p 'my reject'

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

p 'my any and my all'

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p 'my flatten'

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

p 'my zip'

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

p 'my rotate'

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

p 'my join'

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p 'my reverse'

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]