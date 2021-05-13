def zip(*arrays)
    (0...arrays[0].length).map {|i| arrays.map {|array| array[i]}}
end

def prizz_proc(array, prc_1, prc_2)
    array.select do |ele|
        ((prc_1.call(ele) == true && prc_2.call(ele) == false) ||
        (prc_1.call(ele) == false && prc_2.call(ele) == true))
    end
end

def zany_zip(*arrays)
    (0...arrays.max_by(&:length).length).map {|i| arrays.map {|array| array[i]}}
end

def maximum(array, &prc)
    return nil if array.empty?
    max = array[0]
    array.each {|ele| max = ele if prc.call(ele) >= prc.call(max)}
    max
end

def my_group_by(array, &prc)
    hash = Hash.new {|k, v| k[v] = []}
    array.each {|ele| hash[prc.call(ele)] << ele}
    hash
end

def max_tie_breaker(array, prc, &block)
    return nil if array.empty?
    max = array[0]
    array.each do |ele|
        max = ele if block.call(ele) > block.call(max)
        if block.call(ele) == block.call(max)
            res1 = prc.call(ele)
            res2 = prc.call(max)
            max = ele if res1 > res2
        end
    end
    max
end

def silly_syllables(string)
    vowels = "aeiou"
    sentence = string.split(" ")
    newsentence = []
    sentence.each do |word|
        count = 0
        start = word.length
        last = 0
        word.each_char.with_index do |char, id|
            if vowels.include?(char)
                count += 1
                start = id if id < start
                last = id if id > last
            end
        end
        if count >= 2
            newsentence << word[start..last]
        else
            newsentence << word
        end
    end
    newsentence.join(" ")
end