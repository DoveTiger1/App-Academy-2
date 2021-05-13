# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    arr = str.split("")
    newarr = []
    count = 1

    it = 0
    final = 0
    while it < arr.length
        final += 1
        if arr[it] == arr[final]
            while arr[it] == arr[final]
                count +=1
                final +=1
            end
            newarr << count
            it << final+1
            count = 1
        end
        newarr << arr[it]
        it = final
    end
    newarr.join("")
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
