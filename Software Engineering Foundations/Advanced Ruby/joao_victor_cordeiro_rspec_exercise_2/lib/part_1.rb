def partition(arr, num)
    newarr = []
    less = []
    more = []
    arr.each do |ele|
        if ele < num
            less << ele
        else
            more << ele
        end
    end
    newarr << less
    newarr << more
end

def merge(hash1, hash2)
    newhash = {}
    hash1.each { |key, val| newhash[key] = val}
    hash2.each { |key, val| newhash[key] = val}
    newhash
end

def censor(sentence, cwords)
    vowels = "aeiouAEIOU"
    sentence_array = sentence.split(" ")
    sentence_array.each_with_index do |word, i|
        if cwords.include?(word.downcase)
            newword = ""
            word.each_char do |char|
                if vowels.include?(char)
                    newword += "*"
                else
                    newword += char
                end
            end
            sentence_array[i] = newword
        end
    end
    sentence_array.join(" ")
end

def power_of_two?(num)
    (0...num).each do |i|
        if 2**i == num
            return true
        end
    end
    false
end