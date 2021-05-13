def select_even_nums(array)
    array.select(&:even?)
end

def reject_puppies(array)
    array.reject {|dog| dog["age"] <= 2}
end

def count_positive_subarrays(array)
    array.count{ |arr| arr.sum > 0}
end

def aba_translate(string)
    vowels = "aeiou"
    newstr = ""
    string.each_char do |char|
        if vowels.include?(char)
            newstr += char + "b"
        end
        newstr += char
    end
    newstr
end

def aba_array(array)
    array.map{ |ele| aba_translate(ele)}
end