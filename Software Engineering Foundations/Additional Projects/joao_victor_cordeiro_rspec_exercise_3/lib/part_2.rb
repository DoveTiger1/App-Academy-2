def element_count(array)
    values = Hash.new(0)
    array.each {|ele| values[ele] += 1}
    values
end

def char_replace!(string, hash)
    string.each_char.with_index {|char, i| string[i] = hash[char] if hash.has_key?(char)}
    string
end

def product_inject(array)
    array.inject {|sum, n| sum *= n}
end