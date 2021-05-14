def range(rangestart, rangeend)
    return [] if rangeend < rangestart
    return [rangestart] + range(rangestart+1, rangeend)
end

p range(1, 5)

def sum_iterative(array)
    array.inject {|sum, element| sum + element}
end

def sum_recursive(array)
    return 0 if array.length == 0
    return array[0] + sum_recursive(array[1..-1])
end

a = range(1,5)
p sum_iterative(a)
p sum_recursive(a)

def exp_1(base, exponent)
    return 1 if exponent == 0
    return base * exp_1(base, exponent - 1)
end

def exp_2(base, exponent)
    return 1 if exponent == 0
    return base if exponent == 1
    
    half = exp_2(base, exponent/2)

    if exponent.even?
        half * half
    else
        base * half * half
    end
    
end

p exp_1(5, 0)
p exp_1(5, 1)
p exp_1(5, 5)
p exp_2(5, 0)
p exp_2(5, 1)
p exp_2(5, 5)

class Array
    def deep_dup
        newarray = []
        self.each do |element|
            if element.is_a?(Array)
                newarray << element.deep_dup
            else
                newarray << element
            end
        end
        newarray
    end
end


robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy = robot_parts.deep_dup
robot_parts_copy[1] << "LEDs"
p robot_parts
p robot_parts_copy

test_array = [1, [2], [3, [4]]]

p test_array
test_array_2 = test_array.deep_dup
test_array_2 << ['test']
p test_array_2
p test_array

def fibonacci_iterative(number)
    numbers = []
    (0...number).each do |i|
        if i > 1
            numbers << (numbers[i - 1] + numbers[i - 2])
        else
            numbers << 1
        end
    end
    numbers
end

def fibonacci_recursive(number)
    return [0] if number == 0
    return [1] if number == 1
    return [1, 1] if number == 2
    array = fibonacci_recursive(number - 1)
    array << array[-2] + array[-1]
end

p fibonacci_iterative(15)
p fibonacci_recursive(15)

def bsearch(array, target)
    return nil if array.empty?
    middle = (array.length / 2)
    if array[middle] == target
        middle
    elsif target < array[middle]
        bsearch(array[0...middle], target)
    else
        result = bsearch(array[middle + 1..-1], target)
        middle + result + 1 if result != nil
    end
end

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array
    def merge_sort
        return self if self.length <= 1
        middle = self.length / 2
        left_half = self[0...middle].merge_sort
        right_half = self[middle..-1].merge_sort
        merge_helper(left_half, right_half)
    end

    def merge_helper(left_half, right_half)
        finalarray = []
        until left_half.empty? || right_half.empty?
            if left_half.first < right_half.first
                finalarray << left_half.shift
            else
                finalarray << right_half.shift
            end
        end
        finalarray + left_half + right_half
    end
end

p 'merge sort'
a = [38, 27, 43, 3, 9, 82, 10]
p a.merge_sort

p 'subsets'

def subsets(array)
    return [[]] if array.empty?
    subs = subsets(array.take(array.count - 1))
    subs.concat(subs.map { |sub| sub + [array.last] })
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p 'permutations'

def permutations(array)
    return [array] if array.length <= 1
    last = array.shift
    perms = permutations(array)
    total_perms = []

    perms.each do |perm|
        (0..perm.length).each do |index|
            total_perms << perm[0...index] + [last] + perm[index..-1]
        end
    end
    total_perms
end

p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]

p 'make change'

def greedy_make_change(amount, coins = [25, 10, 5, 1])
    return [] if coins.empty?
    totalcoins = []
    while amount >= coins.first
        totalcoins << coins.first
        amount -= coins.first
    end
    totalcoins << greedy_make_change(amount, coins[1..-1])
    totalcoins.flatten
end

def better_make_change(amount, coins = [25, 10, 5, 1])
    return [] if amount == 0
    coins = coins.sort.reverse
    best_change = nil
    coins.each_with_index do |coin, index|
        next if coin > amount
        remainder = amount - coin
        possible_solution = better_make_change(remainder, coins.drop(index))
        next if possible_solution.nil?
        this_change = [coin] + possible_solution
        best_change = this_change if best_change.nil? || this_change.count < best_change.count
    end
    best_change
end

p greedy_make_change(39)
p greedy_make_change(24, [10, 7, 1])
p better_make_change(24, [10, 7, 1])