# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def is_prime?(number)
    (2...number).each do |i|
        return false if number % i == 0
    end
    true
end

def largest_prime_factor(number)
    count = number
    while(count > 0)
        return count if number % count == 0 && is_prime?(count)
        count -= 1
    end
end

def unique_chars?(string)
    chars = ""
    string.each_char do |char|
        if chars.include?(char)
            return false
        else
            chars += char
        end
    end
    true
end

def dupe_indices(array)
    indices = Hash.new { |h, k| h[k] = [] }
    array.each_with_index do |ele, i|
        indices[ele] << i
    end
    indices.select { |key, value| value.length > 1}
end

def ele_count(array)
    count = Hash.new(0)

    array.each {|ele| count[ele] += 1}

    count
end

def ana_array(arr_1, arr_2)
    count_1 = ele_count(arr_1)
    count_2 = ele_count(arr_2)
    count_1 == count_2
end
