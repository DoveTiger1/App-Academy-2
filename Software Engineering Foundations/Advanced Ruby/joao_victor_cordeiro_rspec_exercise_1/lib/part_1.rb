def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(array)
    (array.sum) / array.length.to_f
end

def repeat(str, num)
    str = str*num
end

def yell(str)
    yell = str.upcase + "!"
end

def alternating_case(str)
    arr = str.split(" ")
    newarr = []
    arr.each_with_index do |word, i|
        if i % 2 == 0
            newword = word.upcase
        else
            newword = word.downcase
        end
        newarr << newword
    end
    newarr.join(" ")
end