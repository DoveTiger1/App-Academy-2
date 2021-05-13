def reverser(string, &prc)
    newstr = string.reverse
    prc.call(newstr)
end

def word_changer(string, &prc)
    words = string.split(" ")
    newarr = []
    words.each{ |word| newarr << prc.call(word)}
    newarr.join(" ")
end

def greater_proc_value(num, prc_1, prc_2)
    max = prc_1.call(num) > prc_2.call(num)? prc_1.call(num) : prc_2.call(num)
end

def and_selector(array, prc_1, prc_2)
    newarr = []
    array.each{ |ele| newarr << ele if (prc_1.call(ele) && prc_2.call(ele))}
    newarr
end

def alternating_mapper(array, prc_1, prc_2)
    newarr = []
    array.each_with_index do |ele, i|
        if i % 2 == 0
            newarr << prc_1.call(ele)
        else
            newarr << prc_2.call(ele)
        end
    end
    newarr
end