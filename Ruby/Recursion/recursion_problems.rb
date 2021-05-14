p 'Problem 1:' 

def sum_recur(array)
    return 0 if array.empty?
    array[0] + sum_recur(array[1..-1])
end

p sum_recur([1, 2, 3, 4, 5])

p 'Problem 2:' 

def includes?(array, target)
    return false if array.empty?
    return true if array[0] == target
    includes?(array[1..-1], target)
end

p includes?([1, 2, 3, 4, 5], 3)

p 'Problem 3:' 

def num_occur(array, target)
    return 0 if array.empty?
    count = array.first == target ? 1 : 0
    count = count + num_occur(array[1..-1], target)
end

p num_occur([1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 5], 3)

p 'Problem 4:' 

def add_to_twelve?(array)
    return false if array.length <= 1
    return true if array[0] + array[1] == 12
    add_to_twelve?(array[2..-1])
end

p add_to_twelve?([1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 5])
p add_to_twelve?([1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 5, 7])

p 'Problem 5:' 

def sorted?(array)
    return true if array.length <= 1
    return false if array[0] > array[1]
    sorted?(array[1..-1])
end

p sorted?([1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 5])
p sorted?([1, 7, 2, 2, 3, 4, 3, 3, 12, 4, 5])

p 'Problem 6:' 

def reverse(string)
    return string if string.length == 1
    string[-1] + reverse(string[0...-1])
end

p reverse('string')
p reverse('gnirts')