def two_sum?(arr, target_sum)
    puts
    p bad_two_sum(arr, target_sum)
    p okay_two_sum(arr, target_sum)
    p two_sum(arr, target_sum)
end

def bad_two_sum(arr, target_sum)
    (0...arr.length).each do |i|
        ((i + 1)...arr.length).each do |j|
            return true if arr[i] + arr[j] == target_sum
        end
    end
    false
end


def okay_two_sum(arr, target_sum)
    sorted = arr.sort
    i = 0
    j = arr.length - 1

    while i < j
        if arr[i] + arr[j] == target_sum
            return true
        elsif arr[i] + arr[j] < target_sum
            i += 1
        else
            j -= 1
        end
    end
    false
end

def two_sum(arr, target_sum)
    hash = {}
    arr.each do |ele|
        return true if hash[target_sum - ele]
        hash[ele] = true
    end
    false
end

def four_sum(arr, target_sum)
    
end

arr = [0, 1, 5, 7]
two_sum?(arr, 6) # => should be true
two_sum?(arr, 10) # => should be false