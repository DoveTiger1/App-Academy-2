list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

def my_min_slow(list)
    list.each do |ele_1|
        return ele_1 if list.all? {|ele_2| ele_1 <= ele_2}
    end
end

def my_min_fast(list)
    min = nil
    list.each {|ele| min = ele if min.nil? || ele < min}
    min
end

p my_min_slow(list)
p my_min_fast(list)

list = [2, 3, -6, 7, -6, 7]

def largest_contiguous_subsum_slow(list)
    #time complexity is O(n²) because it iterates que list twice
    sub_arrays = []
    (0...list.length).each do |i|
        new_sub = []
        (i...list.length).each do |j|
            new_sub << list[j]
        end
        sub_arrays << new_sub
    end
    sub_arrays.max.sum
end

def largest_contiguous_subsum_fast(list)
    largest = nil
    current = nil
    (0...list.length).each do |i|
        current = list[i...list.length].sum
        largest = current if largest.nil? || largest < current
    end
    largest
end

p largest_contiguous_subsum_slow(list)
p largest_contiguous_subsum_fast(list)